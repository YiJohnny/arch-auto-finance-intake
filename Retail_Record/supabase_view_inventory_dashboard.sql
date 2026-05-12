create or replace view public.vehicle_inventory_dashboard as
with inventory_vehicles as (
    select
        vms.vehicle_id,
        vms.stock_number,
        vms.vin,
        vms.purchase_date,
        vms.purchase_source,
        vms.status,
        vms.purchase_cost,
        vms.other_direct_cost,
        vms.total_cogs,
        vms.hold_days
    from public.vehicle_master_sheet vms
    where vms.status in (
        'IN_BOUND',
        'IN_INVENTORY',
        'IN_RECONDITION',
        'READY_FOR_SALE',
        'LISTED',
        'PENDING_SALE'
    )
)
select
    count(*)::int as inventory_count_current,
    coalesce(sum(total_cogs), 0)::numeric(14, 2) as inventory_cost_current,
    round(avg(hold_days), 2)::numeric(14, 2) as average_hold_days_current,
    count(*) filter (where hold_days <= 30)::int as aging_0_30_count,
    coalesce(sum(total_cogs) filter (where hold_days <= 30), 0)::numeric(14, 2) as aging_0_30_cost,
    count(*) filter (where hold_days between 31 and 60)::int as aging_31_60_count,
    coalesce(sum(total_cogs) filter (where hold_days between 31 and 60), 0)::numeric(14, 2) as aging_31_60_cost,
    count(*) filter (where hold_days between 61 and 90)::int as aging_61_90_count,
    coalesce(sum(total_cogs) filter (where hold_days between 61 and 90), 0)::numeric(14, 2) as aging_61_90_cost,
    count(*) filter (where hold_days > 90)::int as aging_90_plus_count,
    coalesce(sum(total_cogs) filter (where hold_days > 90), 0)::numeric(14, 2) as aging_90_plus_cost
from inventory_vehicles;
