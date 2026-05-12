alter table public.vehicles
drop constraint if exists vehicles_check;

alter table public.vehicles
add constraint vehicles_check
check (
    (
        status in (
            'IN_BOUND',
            'IN_INVENTORY',
            'IN_RECONDITION',
            'READY_FOR_SALE',
            'LISTED',
            'PENDING_SALE'
        )
        and sale_date is null
        and sale_price is null
        and closed_at is null
    )
    or
    (
        status in ('SOLD', 'WHOLESALE')
        and sale_price is not null
    )
    or
    (status = 'VOID')
);

update public.vehicles
set sale_date = null
where status in ('SOLD', 'WHOLESALE')
  and sale_date is not null
  and purchase_date is not null
  and sale_date < purchase_date;
