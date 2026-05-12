alter table public.vehicles
drop constraint if exists vehicles_status_check;

alter table public.vehicles
drop constraint if exists vehicles_check;

alter table public.vehicles
add constraint vehicles_status_check
check (
    status in (
        'IN_BOUND',
        'IN_INVENTORY',
        'IN_RECONDITION',
        'READY_FOR_SALE',
        'LISTED',
        'PENDING_SALE',
        'SOLD',
        'WHOLESALE',
        'VOID'
    )
);

alter table public.vehicles
add constraint vehicles_check
check (
    (status in (
        'IN_BOUND',
        'IN_INVENTORY',
        'IN_RECONDITION',
        'READY_FOR_SALE',
        'LISTED',
        'PENDING_SALE'
    ) and sale_date is null and sale_price is null and closed_at is null)
    or
    (status in ('SOLD', 'WHOLESALE') and sale_price is not null)
    or
    (status = 'VOID')
);

create table if not exists public.vehicle_status_history (
    status_history_id bigint generated always as identity primary key,
    vehicle_id bigint not null references public.vehicles(vehicle_id) on delete restrict,
    status text not null
        check (
            status in (
                'IN_BOUND',
                'IN_INVENTORY',
                'IN_RECONDITION',
                'READY_FOR_SALE',
                'LISTED',
                'PENDING_SALE',
                'SOLD',
                'WHOLESALE',
                'VOID'
            )
        ),
    effective_at timestamptz not null default now(),
    notes text,
    source_system text not null default 'MANUAL',
    source_record_id text,
    changed_by bigint references public.users(user_id),
    created_at timestamptz not null default now()
);

create index if not exists idx_vehicle_status_history_vehicle_effective_at
    on public.vehicle_status_history(vehicle_id, effective_at desc);

create index if not exists idx_vehicle_status_history_status
    on public.vehicle_status_history(status);

create or replace function public.sync_vehicle_status_history()
returns trigger
language plpgsql
as $$
begin
    if tg_op = 'INSERT' then
        insert into public.vehicle_status_history (
            vehicle_id,
            status,
            effective_at,
            notes,
            source_system,
            source_record_id,
            changed_by
        )
        values (
            new.vehicle_id,
            new.status,
            coalesce(new.created_at, now()),
            'Initial vehicle status',
            'SYSTEM',
            null,
            new.created_by
        );
        return new;
    elsif tg_op = 'UPDATE' and new.status is distinct from old.status then
        insert into public.vehicle_status_history (
            vehicle_id,
            status,
            effective_at,
            notes,
            source_system,
            source_record_id,
            changed_by
        )
        values (
            new.vehicle_id,
            new.status,
            now(),
            'Status changed from ' || old.status || ' to ' || new.status,
            'SYSTEM',
            null,
            coalesce(new.updated_by, old.updated_by, old.created_by)
        );
        return new;
    end if;

    return new;
end;
$$;

drop trigger if exists vehicles_sync_status_history on public.vehicles;

create trigger vehicles_sync_status_history
after insert or update on public.vehicles
for each row
execute function public.sync_vehicle_status_history();

insert into public.vehicle_status_history (
    vehicle_id,
    status,
    effective_at,
    notes,
    source_system,
    changed_by
)
select
    v.vehicle_id,
    v.status,
    coalesce(v.created_at, now()),
    'Backfilled from existing vehicles table',
    'BACKFILL',
    coalesce(v.updated_by, v.created_by)
from public.vehicles v
where not exists (
    select 1
    from public.vehicle_status_history h
    where h.vehicle_id = v.vehicle_id
);
