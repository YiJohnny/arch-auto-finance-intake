create extension if not exists pgcrypto;

create table if not exists public.app_profiles (
    profile_id uuid primary key references auth.users(id) on delete cascade,
    full_name text not null,
    email text,
    role text not null default 'employee'
        check (role in ('employee', 'manager', 'accountant', 'admin')),
    is_active boolean not null default true,
    created_at timestamptz not null default now(),
    updated_at timestamptz not null default now()
);

create table if not exists public.intake_submissions (
    submission_id uuid primary key default gen_random_uuid(),
    submission_number bigint generated always as identity unique,
    submitted_by uuid not null references public.app_profiles(profile_id) on delete restrict,
    business_cluster text not null
        check (business_cluster in ('repair', 'rental', 'retail', 'general')),
    repair_context text
        check (repair_context in ('rental_vehicle', 'retail_inventory', 'walk_in', 'shop_general')),
    direction text not null
        check (direction in ('income', 'expense')),
    status text not null default 'draft'
        check (status in ('draft', 'submitted', 'in_review', 'approved', 'rejected', 'posted', 'voided')),
    vehicle_id bigint references public.vehicles(vehicle_id) on delete restrict,
    transaction_date date,
    amount numeric(12, 2),
    payment_method text
        check (
            payment_method is null
            or payment_method in ('cash', 'check', 'credit_card', 'debit_card', 'ach', 'wire', 'zelle', 'other')
        ),
    card_last4 text check (card_last4 is null or card_last4 ~ '^[0-9]{4}$'),
    counterparty_name text,
    counterparty_type text
        check (
            counterparty_type is null
            or counterparty_type in ('vendor', 'customer', 'employee', 'lender', 'government', 'other')
        ),
    memo text,
    rejection_reason text,
    reviewed_by uuid references public.app_profiles(profile_id) on delete restrict,
    reviewed_at timestamptz,
    posted_at timestamptz,
    created_at timestamptz not null default now(),
    updated_at timestamptz not null default now(),
    check (
        (business_cluster = 'repair' and repair_context is not null)
        or
        (business_cluster <> 'repair' and repair_context is null)
    ),
    check (
        status in ('draft', 'submitted', 'rejected')
        or
        (transaction_date is not null and amount is not null and amount >= 0)
    )
);

create table if not exists public.intake_documents (
    document_id uuid primary key default gen_random_uuid(),
    submission_id uuid not null references public.intake_submissions(submission_id) on delete cascade,
    uploaded_by uuid not null references public.app_profiles(profile_id) on delete restrict,
    storage_bucket text not null default 'intake-documents',
    storage_path text not null unique,
    file_name text not null,
    file_type text not null
        check (file_type in ('receipt_photo', 'pdf', 'manual_entry_attachment', 'other')),
    mime_type text,
    file_size_bytes bigint check (file_size_bytes is null or file_size_bytes >= 0),
    created_at timestamptz not null default now()
);

create table if not exists public.intake_audit_log (
    audit_id bigint generated always as identity primary key,
    submission_id uuid references public.intake_submissions(submission_id) on delete cascade,
    actor_id uuid references public.app_profiles(profile_id) on delete restrict,
    action text not null
        check (action in ('created', 'updated', 'submitted', 'reviewed', 'approved', 'rejected', 'posted', 'voided', 'document_uploaded')),
    old_values jsonb,
    new_values jsonb,
    created_at timestamptz not null default now()
);

create index if not exists idx_app_profiles_role
    on public.app_profiles(role);

create index if not exists idx_intake_submissions_submitted_by_status
    on public.intake_submissions(submitted_by, status);

create index if not exists idx_intake_submissions_cluster_direction
    on public.intake_submissions(business_cluster, direction);

create index if not exists idx_intake_submissions_vehicle
    on public.intake_submissions(vehicle_id);

create index if not exists idx_intake_documents_submission
    on public.intake_documents(submission_id);

create or replace function public.current_app_role()
returns text
language sql
stable
security definer
set search_path = public
as $$
    select role
    from public.app_profiles
    where profile_id = auth.uid()
      and is_active = true
$$;

create or replace function public.is_intake_reviewer()
returns boolean
language sql
stable
security definer
set search_path = public
as $$
    select coalesce(public.current_app_role() in ('manager', 'accountant', 'admin'), false)
$$;

create or replace function public.audit_intake_submission_change()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
declare
    actor uuid;
    action_name text;
begin
    actor := auth.uid();

    if tg_op = 'INSERT' then
        insert into public.intake_audit_log (
            submission_id,
            actor_id,
            action,
            new_values
        )
        values (
            new.submission_id,
            coalesce(actor, new.submitted_by),
            'created',
            to_jsonb(new)
        );
        return new;
    elsif tg_op = 'UPDATE' then
        action_name := case
            when old.status is distinct from new.status and new.status = 'submitted' then 'submitted'
            when old.status is distinct from new.status and new.status = 'approved' then 'approved'
            when old.status is distinct from new.status and new.status = 'rejected' then 'rejected'
            when old.status is distinct from new.status and new.status = 'posted' then 'posted'
            when old.status is distinct from new.status and new.status = 'voided' then 'voided'
            when old.reviewed_by is distinct from new.reviewed_by then 'reviewed'
            else 'updated'
        end;

        insert into public.intake_audit_log (
            submission_id,
            actor_id,
            action,
            old_values,
            new_values
        )
        values (
            new.submission_id,
            coalesce(actor, new.reviewed_by, new.submitted_by),
            action_name,
            to_jsonb(old),
            to_jsonb(new)
        );
        return new;
    end if;

    return null;
end;
$$;

create or replace function public.audit_intake_document_upload()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
    insert into public.intake_audit_log (
        submission_id,
        actor_id,
        action,
        new_values
    )
    values (
        new.submission_id,
        coalesce(auth.uid(), new.uploaded_by),
        'document_uploaded',
        to_jsonb(new)
    );

    return new;
end;
$$;

drop trigger if exists app_profiles_set_updated_at on public.app_profiles;
create trigger app_profiles_set_updated_at
before update on public.app_profiles
for each row
execute function public.set_updated_at();

drop trigger if exists intake_submissions_set_updated_at on public.intake_submissions;
create trigger intake_submissions_set_updated_at
before update on public.intake_submissions
for each row
execute function public.set_updated_at();

drop trigger if exists intake_submissions_audit_change on public.intake_submissions;
create trigger intake_submissions_audit_change
after insert or update on public.intake_submissions
for each row
execute function public.audit_intake_submission_change();

drop trigger if exists intake_documents_audit_upload on public.intake_documents;
create trigger intake_documents_audit_upload
after insert on public.intake_documents
for each row
execute function public.audit_intake_document_upload();

alter table public.app_profiles enable row level security;
alter table public.intake_submissions enable row level security;
alter table public.intake_documents enable row level security;
alter table public.intake_audit_log enable row level security;

drop policy if exists "Profiles can view themselves or admins can view all." on public.app_profiles;
create policy "Profiles can view themselves or admins can view all."
on public.app_profiles
for select
to authenticated
using (
    profile_id = auth.uid()
    or public.current_app_role() = 'admin'
);

drop policy if exists "Admins can manage profiles." on public.app_profiles;
create policy "Admins can manage profiles."
on public.app_profiles
for all
to authenticated
using (public.current_app_role() = 'admin')
with check (public.current_app_role() = 'admin');

drop policy if exists "Employees can create their own submissions." on public.intake_submissions;
create policy "Employees can create their own submissions."
on public.intake_submissions
for insert
to authenticated
with check (
    submitted_by = auth.uid()
    and status in ('draft', 'submitted')
);

drop policy if exists "Users can view permitted submissions." on public.intake_submissions;
create policy "Users can view permitted submissions."
on public.intake_submissions
for select
to authenticated
using (
    submitted_by = auth.uid()
    or public.is_intake_reviewer()
);

drop policy if exists "Employees can update their editable submissions." on public.intake_submissions;
create policy "Employees can update their editable submissions."
on public.intake_submissions
for update
to authenticated
using (
    submitted_by = auth.uid()
    and status in ('draft', 'rejected')
)
with check (
    submitted_by = auth.uid()
    and status in ('draft', 'submitted')
);

drop policy if exists "Reviewers can update submissions." on public.intake_submissions;
create policy "Reviewers can update submissions."
on public.intake_submissions
for update
to authenticated
using (public.is_intake_reviewer())
with check (public.is_intake_reviewer());

drop policy if exists "Users can upload documents to permitted submissions." on public.intake_documents;
create policy "Users can upload documents to permitted submissions."
on public.intake_documents
for insert
to authenticated
with check (
    uploaded_by = auth.uid()
    and exists (
        select 1
        from public.intake_submissions s
        where s.submission_id = intake_documents.submission_id
          and (
              s.submitted_by = auth.uid()
              or public.is_intake_reviewer()
          )
    )
);

drop policy if exists "Users can view permitted submission documents." on public.intake_documents;
create policy "Users can view permitted submission documents."
on public.intake_documents
for select
to authenticated
using (
    exists (
        select 1
        from public.intake_submissions s
        where s.submission_id = intake_documents.submission_id
          and (
              s.submitted_by = auth.uid()
              or public.is_intake_reviewer()
          )
    )
);

drop policy if exists "Reviewers can view intake audit log." on public.intake_audit_log;
create policy "Reviewers can view intake audit log."
on public.intake_audit_log
for select
to authenticated
using (
    public.is_intake_reviewer()
    or exists (
        select 1
        from public.intake_submissions s
        where s.submission_id = intake_audit_log.submission_id
          and s.submitted_by = auth.uid()
    )
);

insert into storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
values (
    'intake-documents',
    'intake-documents',
    false,
    10485760,
    array[
        'image/jpeg',
        'image/png',
        'image/heic',
        'image/heif',
        'application/pdf'
    ]
)
on conflict (id) do nothing;

drop policy if exists "Authenticated users can upload intake documents." on storage.objects;
create policy "Authenticated users can upload intake documents."
on storage.objects
for insert
to authenticated
with check (
    bucket_id = 'intake-documents'
    and owner = auth.uid()
);

drop policy if exists "Authenticated users can read owned or reviewed intake documents." on storage.objects;
create policy "Authenticated users can read owned or reviewed intake documents."
on storage.objects
for select
to authenticated
using (
    bucket_id = 'intake-documents'
    and (
        owner = auth.uid()
        or public.is_intake_reviewer()
    )
);
