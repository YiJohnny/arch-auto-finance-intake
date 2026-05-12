create or replace view public.vehicle_master_sheet as
with cost_summary as (
    select
        l.vehicle_id,
        coalesce(sum(
            case
                when l.is_voided = false and l.entry_type = 'ACQUISITION' and l.category = 'PURCHASE'
                then l.amount
                else 0
            end
        ), 0)::numeric(12, 2) as purchase_cost,
        coalesce(sum(
            case
                when l.is_voided = false and l.entry_type = 'DIRECT_COST' and l.category = 'OTHER_DIRECT_COST'
                then l.amount
                else 0
            end
        ), 0)::numeric(12, 2) as other_direct_cost,
        coalesce(sum(
            case
                when l.is_voided = false and l.entry_type in ('ACQUISITION', 'DIRECT_COST', 'ADJUSTMENT')
                then l.amount
                else 0
            end
        ), 0)::numeric(12, 2) as total_cogs
    from public.vehicle_cost_ledger l
    group by l.vehicle_id
)
select
    v.vehicle_id,
    v.stock_number,
    v.vin,
    v.year,
    v.make,
    v.model,
    v.trim,
    v.color,
    v.mileage,
    v.purchase_date,
    v.purchase_source,
    v.status,
    v.sale_date,
    v.sale_price,
    coalesce(c.purchase_cost, 0)::numeric(12, 2) as purchase_cost,
    coalesce(c.other_direct_cost, 0)::numeric(12, 2) as other_direct_cost,
    coalesce(c.total_cogs, 0)::numeric(12, 2) as total_cogs,
    case
        when v.sale_price is not null then
            (v.sale_price - coalesce(c.total_cogs, 0))::numeric(12, 2)
        else null
    end as gross_profit,
    case
        when v.sale_date is not null then
            (v.sale_date - v.purchase_date)
        else
            (current_date - v.purchase_date)
    end as hold_days
from public.vehicles v
left join cost_summary c
    on c.vehicle_id = v.vehicle_id;
