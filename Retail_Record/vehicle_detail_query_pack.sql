-- Replace 'A1001' with the stock number you want to inspect.

-- 1) Vehicle master summary
select
    vehicle_id,
    stock_number,
    vin,
    year,
    make,
    model,
    trim,
    color,
    mileage,
    purchase_date,
    purchase_source,
    status,
    sale_date,
    sale_price,
    purchase_cost,
    other_direct_cost,
    total_cogs,
    gross_profit,
    hold_days
from public.vehicle_master_sheet
where stock_number = 'A1001';

-- 2) Status history timeline
select
    h.status_history_id,
    v.stock_number,
    h.status,
    h.effective_at,
    h.notes,
    h.source_system,
    h.changed_by
from public.vehicle_status_history h
join public.vehicles v
    on v.vehicle_id = h.vehicle_id
where v.stock_number = 'A1001'
order by h.effective_at, h.status_history_id;

-- 3) Lifetime expense ledger
select
    row_number() over (
        order by l.entry_date, l.ledger_entry_id
    ) as line_no,
    v.stock_number,
    l.entry_date,
    l.entry_type,
    l.category,
    l.amount,
    l.description,
    l.vendor_name,
    l.reference_number,
    l.source_system,
    l.is_voided
from public.vehicle_cost_ledger l
join public.vehicles v
    on v.vehicle_id = l.vehicle_id
where v.stock_number = 'A1001'
order by l.entry_date, l.ledger_entry_id;

-- 4) Cost category breakdown
select
    l.category,
    count(*) as entry_count,
    sum(l.amount)::numeric(14, 2) as category_total
from public.vehicle_cost_ledger l
join public.vehicles v
    on v.vehicle_id = l.vehicle_id
where v.stock_number = 'A1001'
  and l.is_voided = false
group by l.category
order by category_total desc, l.category;

-- 5) Audit trail for this vehicle master record
select
    a.audit_log_id,
    a.table_name,
    a.action,
    a.changed_at,
    a.changed_by,
    a.old_values,
    a.new_values
from public.audit_log a
join public.vehicles v
    on a.record_pk = v.vehicle_id::text
where a.table_name = 'vehicles'
  and v.stock_number = 'A1001'
order by a.changed_at desc, a.audit_log_id desc;

-- 6) Audit trail for ledger entries tied to this vehicle
select
    a.audit_log_id,
    a.table_name,
    a.action,
    a.changed_at,
    a.changed_by,
    a.old_values,
    a.new_values
from public.audit_log a
join public.vehicle_cost_ledger l
    on a.record_pk = l.ledger_entry_id::text
join public.vehicles v
    on v.vehicle_id = l.vehicle_id
where a.table_name = 'vehicle_cost_ledger'
  and v.stock_number = 'A1001'
order by a.changed_at desc, a.audit_log_id desc;
