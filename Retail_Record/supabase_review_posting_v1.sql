create table if not exists public.general_ledger_entries (
    general_ledger_entry_id bigint generated always as identity primary key,
    entry_date date not null,
    business_cluster text not null
        check (business_cluster in ('repair', 'rental', 'retail', 'general')),
    direction text not null
        check (direction in ('income', 'expense')),
    amount numeric(12, 2) not null check (amount >= 0),
    description text,
    counterparty_name text,
    source_system text not null default 'INTAKE',
    source_record_id text,
    posted_by uuid references public.app_profiles(profile_id) on delete restrict,
    created_at timestamptz not null default now(),
    updated_at timestamptz not null default now()
);

alter table public.intake_submissions
add column if not exists vehicle_cost_ledger_entry_id bigint references public.vehicle_cost_ledger(ledger_entry_id) on delete restrict,
add column if not exists general_ledger_entry_id bigint references public.general_ledger_entries(general_ledger_entry_id) on delete restrict;

create index if not exists idx_general_ledger_entries_entry_date
    on public.general_ledger_entries(entry_date);

create index if not exists idx_general_ledger_entries_source
    on public.general_ledger_entries(source_system, source_record_id);

create index if not exists idx_intake_submissions_posting_refs
    on public.intake_submissions(vehicle_cost_ledger_entry_id, general_ledger_entry_id);

drop trigger if exists general_ledger_entries_set_updated_at on public.general_ledger_entries;
create trigger general_ledger_entries_set_updated_at
before update on public.general_ledger_entries
for each row
execute function public.set_updated_at();

alter table public.general_ledger_entries enable row level security;

drop policy if exists "Reviewers can view general ledger entries." on public.general_ledger_entries;
create policy "Reviewers can view general ledger entries."
on public.general_ledger_entries
for select
to authenticated
using (public.is_intake_reviewer());

drop policy if exists "Reviewers can create general ledger entries." on public.general_ledger_entries;
create policy "Reviewers can create general ledger entries."
on public.general_ledger_entries
for insert
to authenticated
with check (public.is_intake_reviewer());

alter table public.vehicle_cost_ledger enable row level security;

drop policy if exists "Reviewers can create intake vehicle ledger entries." on public.vehicle_cost_ledger;
create policy "Reviewers can create intake vehicle ledger entries."
on public.vehicle_cost_ledger
for insert
to authenticated
with check (
    public.is_intake_reviewer()
    and source_system = 'INTAKE'
);

drop policy if exists "Reviewers can view vehicle cost ledger." on public.vehicle_cost_ledger;
create policy "Reviewers can view vehicle cost ledger."
on public.vehicle_cost_ledger
for select
to authenticated
using (public.is_intake_reviewer());

alter table public.audit_log enable row level security;

drop policy if exists "Reviewers can create intake audit log rows." on public.audit_log;
create policy "Reviewers can create intake audit log rows."
on public.audit_log
for insert
to authenticated
with check (
    public.is_intake_reviewer()
    and table_name in ('vehicle_cost_ledger', 'vehicles')
);

drop policy if exists "Reviewers can view audit log." on public.audit_log;
create policy "Reviewers can view audit log."
on public.audit_log
for select
to authenticated
using (public.is_intake_reviewer());
