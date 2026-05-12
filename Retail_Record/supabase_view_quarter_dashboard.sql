create or replace view public.vehicle_quarter_dashboard as
with sold_vehicles as (
    select
        vms.vehicle_id,
        vms.stock_number,
        vms.vin,
        vms.purchase_source,
        vms.sale_date,
        vms.sale_price,
        vms.purchase_cost,
        vms.other_direct_cost,
        vms.total_cogs,
        vms.gross_profit,
        vms.hold_days,
        extract(year from vms.sale_date)::int as sale_year,
        extract(quarter from vms.sale_date)::int as sale_quarter
    from public.vehicle_master_sheet vms
    where vms.status in ('SOLD', 'WHOLESALE')
      and vms.sale_date is not null
      and vms.sale_price is not null
)
select
    sale_year,
    sale_quarter,
    make_date(sale_year, ((sale_quarter - 1) * 3) + 1, 1) as quarter_start_date,
    count(*)::int as vehicles_sold_count,
    coalesce(sum(sale_price), 0)::numeric(14, 2) as quarter_revenue,
    coalesce(sum(total_cogs), 0)::numeric(14, 2) as quarter_cogs,
    coalesce(sum(gross_profit), 0)::numeric(14, 2) as quarter_gross_profit,
    case
        when coalesce(sum(sale_price), 0) = 0 then null
        else round((sum(gross_profit) / sum(sale_price)) * 100, 2)
    end as gross_profit_pct,
    round(avg(sale_price), 2)::numeric(14, 2) as average_sale_price,
    round(avg(total_cogs), 2)::numeric(14, 2) as average_cogs_per_vehicle,
    round(avg(gross_profit), 2)::numeric(14, 2) as average_gross_profit_per_vehicle,
    round(avg(hold_days), 2)::numeric(14, 2) as average_hold_days_sold
from sold_vehicles
group by sale_year, sale_quarter
order by sale_year desc, sale_quarter desc;
