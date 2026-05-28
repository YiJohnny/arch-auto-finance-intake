alter table public.intake_submissions
add column if not exists unmatched_vehicle_vin text,
add column if not exists unmatched_vehicle_year integer,
add column if not exists unmatched_vehicle_make text,
add column if not exists unmatched_vehicle_model text,
add column if not exists unmatched_vehicle_stock_number text;

alter table public.intake_submissions
drop constraint if exists intake_submissions_vehicle_match_check;

alter table public.intake_submissions
add constraint intake_submissions_vehicle_match_check
check (
    vehicle_id is null
    or (
        unmatched_vehicle_vin is null
        and unmatched_vehicle_year is null
        and unmatched_vehicle_make is null
        and unmatched_vehicle_model is null
        and unmatched_vehicle_stock_number is null
    )
);

alter table public.vehicles
add column if not exists business_use text
    check (
        business_use is null
        or business_use in ('retail', 'rental', 'repair_shop', 'general')
    );

create index if not exists idx_vehicles_business_use
    on public.vehicles(business_use);

alter table public.vehicles
add column if not exists fund_allocation text;

create index if not exists idx_vehicles_fund_allocation
    on public.vehicles(fund_allocation);
