create extension if not exists pgcrypto;

create table public.users (
    user_id bigint generated always as identity primary key,
    username text not null unique,
    full_name text,
    email text,
    is_active boolean not null default true,
    created_at timestamptz not null default now(),
    updated_at timestamptz not null default now()
);

create table public.vehicles (
    vehicle_id bigint generated always as identity primary key,
    stock_number text not null unique,
    vin text not null unique,
    year integer,
    make text not null,
    model text not null,
    trim text,
    color text,
    mileage integer,
    purchase_date date not null,
    purchase_source text,
    status text not null default 'IN_INVENTORY'
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
    acquisition_notes text,
    sale_date date,
    sale_price numeric(12, 2),
    sale_channel text,
    buyer_name text,
    dealercenter_deal_id text,
    created_at timestamptz not null default now(),
    created_by bigint references public.users(user_id),
    updated_at timestamptz not null default now(),
    updated_by bigint references public.users(user_id),
    closed_at timestamptz,
    closed_by bigint references public.users(user_id),
    check (char_length(vin) between 11 and 17),
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
    )
);

create table public.vehicle_status_history (
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

create table public.vehicle_cost_ledger (
    ledger_entry_id bigint generated always as identity primary key,
    vehicle_id bigint not null references public.vehicles(vehicle_id) on delete restrict,
    entry_date date not null,
    entry_type text not null
        check (entry_type in ('ACQUISITION', 'DIRECT_COST', 'ADJUSTMENT', 'SALE', 'REVERSAL')),
    category text not null,
    amount numeric(12, 2) not null,
    description text,
    vendor_name text,
    reference_number text,
    source_system text not null default 'MANUAL',
    source_record_id text,
    entered_by bigint references public.users(user_id),
    is_voided boolean not null default false,
    voided_at timestamptz,
    voided_by bigint references public.users(user_id),
    created_at timestamptz not null default now(),
    updated_at timestamptz not null default now(),
    check (
        category in (
            'PURCHASE',
            'AUCTION_FEE',
            'BUYER_FEE',
            'TRANSPORTATION',
            'TOWING',
            'FUEL',
            'TITLE_FEE',
            'REGISTRATION_FEE',
            'INSPECTION',
            'SMOG',
            'REPAIR',
            'PARTS',
            'DETAIL',
            'CLEANING',
            'PHOTOGRAPHY',
            'KEY_REPLACEMENT',
            'WARRANTY_REPAIR',
            'OTHER_DIRECT_COST',
            'SALE_PROCEEDS',
            'COST_ADJUSTMENT',
            'REVERSAL'
        )
    ),
    check (
        (entry_type = 'ACQUISITION' and category = 'PURCHASE')
        or
        (entry_type = 'DIRECT_COST' and category in (
            'AUCTION_FEE',
            'BUYER_FEE',
            'TRANSPORTATION',
            'TOWING',
            'FUEL',
            'TITLE_FEE',
            'REGISTRATION_FEE',
            'INSPECTION',
            'SMOG',
            'REPAIR',
            'PARTS',
            'DETAIL',
            'CLEANING',
            'PHOTOGRAPHY',
            'KEY_REPLACEMENT',
            'WARRANTY_REPAIR',
            'OTHER_DIRECT_COST'
        ))
        or
        (entry_type = 'ADJUSTMENT' and category = 'COST_ADJUSTMENT')
        or
        (entry_type = 'SALE' and category = 'SALE_PROCEEDS')
        or
        (entry_type = 'REVERSAL' and category = 'REVERSAL')
    ),
    check (
        (is_voided = false and voided_at is null and voided_by is null)
        or
        (is_voided = true and voided_at is not null)
    )
);

create table public.audit_log (
    audit_log_id bigint generated always as identity primary key,
    table_name text not null,
    record_pk text not null,
    action text not null check (action in ('INSERT', 'UPDATE', 'DELETE')),
    changed_at timestamptz not null default now(),
    changed_by bigint references public.users(user_id),
    old_values jsonb,
    new_values jsonb
);

create or replace function public.set_updated_at()
returns trigger
language plpgsql
as $$
begin
    new.updated_at = now();
    return new;
end;
$$;

create or replace function public.audit_vehicle_change()
returns trigger
language plpgsql
as $$
begin
    if tg_op = 'INSERT' then
        insert into public.audit_log (
            table_name,
            record_pk,
            action,
            changed_by,
            new_values
        )
        values (
            'vehicles',
            new.vehicle_id::text,
            'INSERT',
            new.created_by,
            jsonb_build_object(
                'stock_number', new.stock_number,
                'vin', new.vin,
                'status', new.status,
                'purchase_date', new.purchase_date,
                'sale_date', new.sale_date,
                'sale_price', new.sale_price
            )
        );
        return new;
    elsif tg_op = 'UPDATE' then
        insert into public.audit_log (
            table_name,
            record_pk,
            action,
            changed_by,
            old_values,
            new_values
        )
        values (
            'vehicles',
            new.vehicle_id::text,
            'UPDATE',
            coalesce(new.updated_by, old.updated_by),
            jsonb_build_object(
                'stock_number', old.stock_number,
                'vin', old.vin,
                'status', old.status,
                'purchase_date', old.purchase_date,
                'sale_date', old.sale_date,
                'sale_price', old.sale_price
            ),
            jsonb_build_object(
                'stock_number', new.stock_number,
                'vin', new.vin,
                'status', new.status,
                'purchase_date', new.purchase_date,
                'sale_date', new.sale_date,
                'sale_price', new.sale_price
            )
        );
        return new;
    end if;

    return null;
end;
$$;

create or replace function public.audit_ledger_change()
returns trigger
language plpgsql
as $$
begin
    if tg_op = 'INSERT' then
        insert into public.audit_log (
            table_name,
            record_pk,
            action,
            changed_by,
            new_values
        )
        values (
            'vehicle_cost_ledger',
            new.ledger_entry_id::text,
            'INSERT',
            new.entered_by,
            jsonb_build_object(
                'vehicle_id', new.vehicle_id,
                'entry_date', new.entry_date,
                'entry_type', new.entry_type,
                'category', new.category,
                'amount', new.amount,
                'is_voided', new.is_voided
            )
        );
        return new;
    elsif tg_op = 'UPDATE' then
        insert into public.audit_log (
            table_name,
            record_pk,
            action,
            changed_by,
            old_values,
            new_values
        )
        values (
            'vehicle_cost_ledger',
            new.ledger_entry_id::text,
            'UPDATE',
            coalesce(new.entered_by, old.entered_by),
            jsonb_build_object(
                'vehicle_id', old.vehicle_id,
                'entry_date', old.entry_date,
                'entry_type', old.entry_type,
                'category', old.category,
                'amount', old.amount,
                'is_voided', old.is_voided
            ),
            jsonb_build_object(
                'vehicle_id', new.vehicle_id,
                'entry_date', new.entry_date,
                'entry_type', new.entry_type,
                'category', new.category,
                'amount', new.amount,
                'is_voided', new.is_voided
            )
        );
        return new;
    end if;

    return null;
end;
$$;

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

create or replace view public.vehicle_profit_snapshot as
select
    v.vehicle_id,
    v.stock_number,
    v.vin,
    v.year,
    v.make,
    v.model,
    v.status,
    v.purchase_date,
    v.sale_date,
    v.sale_price,
    coalesce(sum(
        case
            when l.is_voided = false
             and l.entry_type in ('ACQUISITION', 'DIRECT_COST', 'ADJUSTMENT')
            then l.amount
            else 0
        end
    ), 0)::numeric(12, 2) as total_cogs,
    case
        when v.sale_price is not null then
            (v.sale_price - coalesce(sum(
                case
                    when l.is_voided = false
                     and l.entry_type in ('ACQUISITION', 'DIRECT_COST', 'ADJUSTMENT')
                    then l.amount
                    else 0
                end
            ), 0))::numeric(12, 2)
        else null
    end as gross_profit
from public.vehicles v
left join public.vehicle_cost_ledger l
    on l.vehicle_id = v.vehicle_id
group by
    v.vehicle_id,
    v.stock_number,
    v.vin,
    v.year,
    v.make,
    v.model,
    v.status,
    v.purchase_date,
    v.sale_date,
    v.sale_price;

create index idx_vehicles_status on public.vehicles(status);
create index idx_vehicles_purchase_date on public.vehicles(purchase_date);
create index idx_vehicle_cost_ledger_vehicle_date
    on public.vehicle_cost_ledger(vehicle_id, entry_date);
create index idx_vehicle_status_history_vehicle_effective_at
    on public.vehicle_status_history(vehicle_id, effective_at desc);
create index idx_vehicle_status_history_status
    on public.vehicle_status_history(status);
create index idx_vehicle_cost_ledger_source
    on public.vehicle_cost_ledger(source_system, source_record_id);
create index idx_audit_log_table_record
    on public.audit_log(table_name, record_pk, changed_at desc);

create trigger users_set_updated_at
before update on public.users
for each row
execute function public.set_updated_at();

create trigger vehicles_set_updated_at
before update on public.vehicles
for each row
execute function public.set_updated_at();

create trigger vehicle_cost_ledger_set_updated_at
before update on public.vehicle_cost_ledger
for each row
execute function public.set_updated_at();

create trigger vehicles_audit_change
after insert or update on public.vehicles
for each row
execute function public.audit_vehicle_change();

create trigger vehicle_cost_ledger_audit_change
after insert or update on public.vehicle_cost_ledger
for each row
execute function public.audit_ledger_change();

create trigger vehicles_sync_status_history
after insert or update on public.vehicles
for each row
execute function public.sync_vehicle_status_history();
