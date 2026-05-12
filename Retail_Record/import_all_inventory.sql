-- Generated from All Inventory.xlsx

-- Assumption: SOLD rows use Created Date as a temporary sale_date when a true sale close date is unavailable.

begin;

insert into public.vehicles (
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
    acquisition_notes
) values (
    'NV559167',
    'WBA3X5C59ED559167',
    2014,
    'BMW',
    '3 SERIES',
    '328I GRAN TURISMO XDRIVE SEDAN 4D',
    'BLACK',
    138297,
    '2025-01-02',
    'SOLD',
    'SOLD',
    '2025-01-02',
    4740.91,
    'Imported from All Inventory.xlsx row 2'
) on conflict (vin) do nothing;

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2025-01-02',
    'ACQUISITION',
    'PURCHASE',
    2700.00,
    'Imported initial purchase cost from legacy inventory summary',
    'LEGACY_IMPORT',
    'WBA3X5C59ED559167'
from public.vehicles v
where v.vin = 'WBA3X5C59ED559167'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'ACQUISITION'
        and l.category = 'PURCHASE'
  );

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2025-01-02',
    'DIRECT_COST',
    'OTHER_DIRECT_COST',
    296.43,
    'Imported historical direct costs from legacy inventory summary',
    'LEGACY_IMPORT',
    'WBA3X5C59ED559167:other_direct_cost'
from public.vehicles v
where v.vin = 'WBA3X5C59ED559167'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'DIRECT_COST'
        and l.category = 'OTHER_DIRECT_COST'
        and l.source_record_id = 'WBA3X5C59ED559167:other_direct_cost'
  );

insert into public.vehicles (
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
    acquisition_notes
) values (
    'JC135918',
    '2T2BZMCA8JC135918',
    2018,
    'LEXUS',
    'RX',
    'RX 350 F SPORT SUV 4D',
    'BLACK',
    39973,
    '2024-02-08',
    'SOLD',
    'SOLD',
    '2024-02-08',
    30800.00,
    'Imported from All Inventory.xlsx row 4'
) on conflict (vin) do nothing;

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2024-02-08',
    'ACQUISITION',
    'PURCHASE',
    28000.00,
    'Imported initial purchase cost from legacy inventory summary',
    'LEGACY_IMPORT',
    '2T2BZMCA8JC135918'
from public.vehicles v
where v.vin = '2T2BZMCA8JC135918'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'ACQUISITION'
        and l.category = 'PURCHASE'
  );

insert into public.vehicles (
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
    acquisition_notes
) values (
    'NV323329',
    '2T3RFREV1FW323329',
    2015,
    'TOYOTA',
    'RAV4',
    'XLE SPORT UTILITY 4D',
    'GRAY',
    93409,
    '2024-12-14',
    'SOLD',
    'SOLD',
    '2024-12-14',
    11875.00,
    'Imported from All Inventory.xlsx row 5'
) on conflict (vin) do nothing;

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2024-12-14',
    'ACQUISITION',
    'PURCHASE',
    10000.00,
    'Imported initial purchase cost from legacy inventory summary',
    'LEGACY_IMPORT',
    '2T3RFREV1FW323329'
from public.vehicles v
where v.vin = '2T3RFREV1FW323329'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'ACQUISITION'
        and l.category = 'PURCHASE'
  );

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2024-12-14',
    'DIRECT_COST',
    'OTHER_DIRECT_COST',
    17.00,
    'Imported historical direct costs from legacy inventory summary',
    'LEGACY_IMPORT',
    '2T3RFREV1FW323329:other_direct_cost'
from public.vehicles v
where v.vin = '2T3RFREV1FW323329'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'DIRECT_COST'
        and l.category = 'OTHER_DIRECT_COST'
        and l.source_record_id = '2T3RFREV1FW323329:other_direct_cost'
  );

insert into public.vehicles (
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
    acquisition_notes
) values (
    'TI010402',
    'JF1VBAA60N9010402',
    2022,
    'SUBARU',
    'WRX',
    'SEDAN 4D',
    'BLUE',
    16829,
    '2025-07-22',
    'SOLD',
    'SOLD',
    '2025-07-16',
    24600.00,
    'Imported from All Inventory.xlsx row 6'
) on conflict (vin) do nothing;

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2025-07-22',
    'ACQUISITION',
    'PURCHASE',
    24300.00,
    'Imported initial purchase cost from legacy inventory summary',
    'LEGACY_IMPORT',
    'JF1VBAA60N9010402'
from public.vehicles v
where v.vin = 'JF1VBAA60N9010402'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'ACQUISITION'
        and l.category = 'PURCHASE'
  );

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2025-07-22',
    'DIRECT_COST',
    'OTHER_DIRECT_COST',
    483.07,
    'Imported historical direct costs from legacy inventory summary',
    'LEGACY_IMPORT',
    'JF1VBAA60N9010402:other_direct_cost'
from public.vehicles v
where v.vin = 'JF1VBAA60N9010402'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'DIRECT_COST'
        and l.category = 'OTHER_DIRECT_COST'
        and l.source_record_id = 'JF1VBAA60N9010402:other_direct_cost'
  );

insert into public.vehicles (
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
    acquisition_notes
) values (
    'NV118670',
    '2T2BZMCA9HC118670',
    2017,
    'LEXUS',
    'RX',
    'RX 350 SPORT UTILITY 4D',
    'SILVER',
    81236,
    '2024-11-12',
    'SOLD',
    'SOLD',
    '2024-11-12',
    24000.00,
    'Imported from All Inventory.xlsx row 7'
) on conflict (vin) do nothing;

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2024-11-12',
    'ACQUISITION',
    'PURCHASE',
    18750.00,
    'Imported initial purchase cost from legacy inventory summary',
    'LEGACY_IMPORT',
    '2T2BZMCA9HC118670'
from public.vehicles v
where v.vin = '2T2BZMCA9HC118670'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'ACQUISITION'
        and l.category = 'PURCHASE'
  );

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2024-11-12',
    'DIRECT_COST',
    'OTHER_DIRECT_COST',
    952.00,
    'Imported historical direct costs from legacy inventory summary',
    'LEGACY_IMPORT',
    '2T2BZMCA9HC118670:other_direct_cost'
from public.vehicles v
where v.vin = '2T2BZMCA9HC118670'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'DIRECT_COST'
        and l.category = 'OTHER_DIRECT_COST'
        and l.source_record_id = '2T2BZMCA9HC118670:other_direct_cost'
  );

insert into public.vehicles (
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
    acquisition_notes
) values (
    'NV094616',
    '3KPFK4A79HE094616',
    2017,
    'KIA',
    'FORTE',
    'LX SEDAN 4D',
    'BLACK',
    90459,
    '2026-04-14',
    'IN INVENTORY',
    'IN_INVENTORY',
    null,
    null,
    'Imported from All Inventory.xlsx row 8'
) on conflict (vin) do nothing;

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2026-04-14',
    'ACQUISITION',
    'PURCHASE',
    5000.00,
    'Imported initial purchase cost from legacy inventory summary',
    'LEGACY_IMPORT',
    '3KPFK4A79HE094616'
from public.vehicles v
where v.vin = '3KPFK4A79HE094616'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'ACQUISITION'
        and l.category = 'PURCHASE'
  );

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2026-04-14',
    'DIRECT_COST',
    'OTHER_DIRECT_COST',
    125.30,
    'Imported historical direct costs from legacy inventory summary',
    'LEGACY_IMPORT',
    '3KPFK4A79HE094616:other_direct_cost'
from public.vehicles v
where v.vin = '3KPFK4A79HE094616'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'DIRECT_COST'
        and l.category = 'OTHER_DIRECT_COST'
        and l.source_record_id = '3KPFK4A79HE094616:other_direct_cost'
  );

insert into public.vehicles (
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
    acquisition_notes
) values (
    'NV718006',
    '1C6RR7FT1FS718006',
    2015,
    'RAM',
    '1500 QUAD CAB',
    'EXPRESS PICKUP 4D 6 1/3 FT',
    null,
    147672,
    '2026-04-17',
    'INBOUND',
    'IN_BOUND',
    null,
    null,
    'Imported from All Inventory.xlsx row 10'
) on conflict (vin) do nothing;

insert into public.vehicles (
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
    acquisition_notes
) values (
    'NV129939',
    '4JGFF5KE3LA129939',
    2020,
    'MERCEDES-BENZ',
    'GLS',
    'GLS 450 4MATIC SPORT UTILITY 4D',
    'BLACK',
    62300,
    '2025-02-07',
    'SOLD',
    'SOLD',
    '2024-11-21',
    28500.00,
    'Imported from All Inventory.xlsx row 11'
) on conflict (vin) do nothing;

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2025-02-07',
    'ACQUISITION',
    'PURCHASE',
    25000.00,
    'Imported initial purchase cost from legacy inventory summary',
    'LEGACY_IMPORT',
    '4JGFF5KE3LA129939'
from public.vehicles v
where v.vin = '4JGFF5KE3LA129939'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'ACQUISITION'
        and l.category = 'PURCHASE'
  );

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2025-02-07',
    'DIRECT_COST',
    'OTHER_DIRECT_COST',
    300.00,
    'Imported historical direct costs from legacy inventory summary',
    'LEGACY_IMPORT',
    '4JGFF5KE3LA129939:other_direct_cost'
from public.vehicles v
where v.vin = '4JGFF5KE3LA129939'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'DIRECT_COST'
        and l.category = 'OTHER_DIRECT_COST'
        and l.source_record_id = '4JGFF5KE3LA129939:other_direct_cost'
  );

insert into public.vehicles (
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
    acquisition_notes
) values (
    'TI187925',
    '55SWF8GB5HU187925',
    2017,
    'MERCEDES-BENZ',
    'MERCEDES-AMG C-CLASS',
    'C 63 AMG SEDAN 4D',
    'BLACK',
    32130,
    '2026-04-06',
    'SOLD',
    'SOLD',
    '2026-04-06',
    36000.00,
    'Imported from All Inventory.xlsx row 13'
) on conflict (vin) do nothing;

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2026-04-06',
    'ACQUISITION',
    'PURCHASE',
    29000.00,
    'Imported initial purchase cost from legacy inventory summary',
    'LEGACY_IMPORT',
    '55SWF8GB5HU187925'
from public.vehicles v
where v.vin = '55SWF8GB5HU187925'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'ACQUISITION'
        and l.category = 'PURCHASE'
  );

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2026-04-06',
    'DIRECT_COST',
    'OTHER_DIRECT_COST',
    71.14,
    'Imported historical direct costs from legacy inventory summary',
    'LEGACY_IMPORT',
    '55SWF8GB5HU187925:other_direct_cost'
from public.vehicles v
where v.vin = '55SWF8GB5HU187925'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'DIRECT_COST'
        and l.category = 'OTHER_DIRECT_COST'
        and l.source_record_id = '55SWF8GB5HU187925:other_direct_cost'
  );

insert into public.vehicles (
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
    acquisition_notes
) values (
    'NV092850',
    'JTEAAAAH9NJ092850',
    2022,
    'TOYOTA',
    'VENZA',
    'XLE SPORT UTILITY 4D',
    'BLACK',
    24930,
    '2025-09-04',
    'SOLD',
    'SOLD',
    '2025-08-31',
    26700.00,
    'Imported from All Inventory.xlsx row 14'
) on conflict (vin) do nothing;

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2025-09-04',
    'ACQUISITION',
    'PURCHASE',
    27000.00,
    'Imported initial purchase cost from legacy inventory summary',
    'LEGACY_IMPORT',
    'JTEAAAAH9NJ092850'
from public.vehicles v
where v.vin = 'JTEAAAAH9NJ092850'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'ACQUISITION'
        and l.category = 'PURCHASE'
  );

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2025-09-04',
    'DIRECT_COST',
    'OTHER_DIRECT_COST',
    160.00,
    'Imported historical direct costs from legacy inventory summary',
    'LEGACY_IMPORT',
    'JTEAAAAH9NJ092850:other_direct_cost'
from public.vehicles v
where v.vin = 'JTEAAAAH9NJ092850'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'DIRECT_COST'
        and l.category = 'OTHER_DIRECT_COST'
        and l.source_record_id = 'JTEAAAAH9NJ092850:other_direct_cost'
  );

insert into public.vehicles (
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
    acquisition_notes
) values (
    'NV537952',
    '2C4RC1EG4HR537952',
    2017,
    'CHRYSLER',
    'PACIFICA',
    'TOURING-L PLUS MINIVAN 4D',
    'GRAY',
    42620,
    '2024-05-24',
    'SOLD',
    'SOLD',
    '2024-05-24',
    16375.00,
    'Imported from All Inventory.xlsx row 16'
) on conflict (vin) do nothing;

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2024-05-24',
    'ACQUISITION',
    'PURCHASE',
    14500.00,
    'Imported initial purchase cost from legacy inventory summary',
    'LEGACY_IMPORT',
    '2C4RC1EG4HR537952'
from public.vehicles v
where v.vin = '2C4RC1EG4HR537952'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'ACQUISITION'
        and l.category = 'PURCHASE'
  );

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2024-05-24',
    'DIRECT_COST',
    'OTHER_DIRECT_COST',
    25.00,
    'Imported historical direct costs from legacy inventory summary',
    'LEGACY_IMPORT',
    '2C4RC1EG4HR537952:other_direct_cost'
from public.vehicles v
where v.vin = '2C4RC1EG4HR537952'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'DIRECT_COST'
        and l.category = 'OTHER_DIRECT_COST'
        and l.source_record_id = '2C4RC1EG4HR537952:other_direct_cost'
  );

insert into public.vehicles (
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
    acquisition_notes
) values (
    'NC447677',
    '7SAYGDEE1TA447677',
    2026,
    'TESLA',
    'MODEL Y',
    'LAUNCH SERIES LONG RANGE SPORT UTILITY 4D',
    'DIAMOND BLACK',
    12500,
    '2025-08-06',
    'SOLD',
    'SOLD',
    '2025-08-06',
    39000.00,
    'Imported from All Inventory.xlsx row 18'
) on conflict (vin) do nothing;

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2025-08-06',
    'ACQUISITION',
    'PURCHASE',
    46022.00,
    'Imported initial purchase cost from legacy inventory summary',
    'LEGACY_IMPORT',
    '7SAYGDEE1TA447677'
from public.vehicles v
where v.vin = '7SAYGDEE1TA447677'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'ACQUISITION'
        and l.category = 'PURCHASE'
  );

insert into public.vehicles (
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
    acquisition_notes
) values (
    'NVA40640',
    'WP1BA2AYXMDA40640',
    2021,
    'PORSCHE',
    'CAYENNE COUPE',
    'SPORT UTILITY 4D',
    'GRAY',
    41130,
    '2025-09-23',
    'SOLD',
    'SOLD',
    '2025-09-23',
    48565.00,
    'Imported from All Inventory.xlsx row 19'
) on conflict (vin) do nothing;

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2025-09-23',
    'ACQUISITION',
    'PURCHASE',
    46945.00,
    'Imported initial purchase cost from legacy inventory summary',
    'LEGACY_IMPORT',
    'WP1BA2AYXMDA40640'
from public.vehicles v
where v.vin = 'WP1BA2AYXMDA40640'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'ACQUISITION'
        and l.category = 'PURCHASE'
  );

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2025-09-23',
    'DIRECT_COST',
    'OTHER_DIRECT_COST',
    1200.00,
    'Imported historical direct costs from legacy inventory summary',
    'LEGACY_IMPORT',
    'WP1BA2AYXMDA40640:other_direct_cost'
from public.vehicles v
where v.vin = 'WP1BA2AYXMDA40640'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'DIRECT_COST'
        and l.category = 'OTHER_DIRECT_COST'
        and l.source_record_id = 'WP1BA2AYXMDA40640:other_direct_cost'
  );

insert into public.vehicles (
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
    acquisition_notes
) values (
    'NV106174',
    'WA1D7AFP5GA106174',
    2016,
    'AUDI',
    'Q5',
    '3.0T PREMIUM PLUS SPORT UTILITY 4D',
    'BLUE',
    78087,
    '2025-09-03',
    'SOLD',
    'SOLD',
    '2025-09-03',
    13000.00,
    'Imported from All Inventory.xlsx row 20'
) on conflict (vin) do nothing;

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2025-09-03',
    'ACQUISITION',
    'PURCHASE',
    12295.41,
    'Imported initial purchase cost from legacy inventory summary',
    'LEGACY_IMPORT',
    'WA1D7AFP5GA106174'
from public.vehicles v
where v.vin = 'WA1D7AFP5GA106174'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'ACQUISITION'
        and l.category = 'PURCHASE'
  );

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2025-09-03',
    'DIRECT_COST',
    'OTHER_DIRECT_COST',
    88.42,
    'Imported historical direct costs from legacy inventory summary',
    'LEGACY_IMPORT',
    'WA1D7AFP5GA106174:other_direct_cost'
from public.vehicles v
where v.vin = 'WA1D7AFP5GA106174'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'DIRECT_COST'
        and l.category = 'OTHER_DIRECT_COST'
        and l.source_record_id = 'WA1D7AFP5GA106174:other_direct_cost'
  );

insert into public.vehicles (
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
    acquisition_notes
) values (
    'NW047487',
    'WZ1DB2C00NW047487',
    2022,
    'TOYOTA',
    'GR SUPRA',
    '2.0 COUPE 2D',
    null,
    9223,
    '2024-01-21',
    'SOLD',
    'SOLD',
    '2024-01-21',
    41725.00,
    'Imported from All Inventory.xlsx row 21'
) on conflict (vin) do nothing;

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2024-01-21',
    'ACQUISITION',
    'PURCHASE',
    40580.00,
    'Imported initial purchase cost from legacy inventory summary',
    'LEGACY_IMPORT',
    'WZ1DB2C00NW047487'
from public.vehicles v
where v.vin = 'WZ1DB2C00NW047487'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'ACQUISITION'
        and l.category = 'PURCHASE'
  );

insert into public.vehicles (
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
    acquisition_notes
) values (
    'NV101696',
    '3PCAJ5M36LF101696',
    2020,
    'INFINITI',
    'QX50',
    'LUXE SPORT UTILITY 4D',
    'BLUE',
    37299,
    '2024-07-26',
    'SOLD',
    'SOLD',
    '2024-07-26',
    24000.00,
    'Imported from All Inventory.xlsx row 24'
) on conflict (vin) do nothing;

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2024-07-26',
    'ACQUISITION',
    'PURCHASE',
    22300.00,
    'Imported initial purchase cost from legacy inventory summary',
    'LEGACY_IMPORT',
    '3PCAJ5M36LF101696'
from public.vehicles v
where v.vin = '3PCAJ5M36LF101696'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'ACQUISITION'
        and l.category = 'PURCHASE'
  );

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2024-07-26',
    'DIRECT_COST',
    'OTHER_DIRECT_COST',
    240.00,
    'Imported historical direct costs from legacy inventory summary',
    'LEGACY_IMPORT',
    '3PCAJ5M36LF101696:other_direct_cost'
from public.vehicles v
where v.vin = '3PCAJ5M36LF101696'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'DIRECT_COST'
        and l.category = 'OTHER_DIRECT_COST'
        and l.source_record_id = '3PCAJ5M36LF101696:other_direct_cost'
  );

insert into public.vehicles (
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
    acquisition_notes
) values (
    'TI054309',
    'WAUBFGFF7F1054309',
    2015,
    'AUDI',
    'A3',
    '2.0T PREMIUM SEDAN 4D',
    'WHITE',
    127641,
    '2026-03-21',
    'SOLD',
    'SOLD',
    '2026-03-21',
    5962.00,
    'Imported from All Inventory.xlsx row 25'
) on conflict (vin) do nothing;

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2026-03-21',
    'ACQUISITION',
    'PURCHASE',
    5000.00,
    'Imported initial purchase cost from legacy inventory summary',
    'LEGACY_IMPORT',
    'WAUBFGFF7F1054309'
from public.vehicles v
where v.vin = 'WAUBFGFF7F1054309'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'ACQUISITION'
        and l.category = 'PURCHASE'
  );

insert into public.vehicles (
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
    acquisition_notes
) values (
    'NVH96365',
    'WBA73AP07NCH96365',
    2022,
    'BMW',
    '4 SERIES',
    '430I XDRIVE COUPE 2D',
    null,
    46514,
    '2025-09-17',
    'SOLD',
    'SOLD',
    '2025-09-17',
    33538.00,
    'Imported from All Inventory.xlsx row 26'
) on conflict (vin) do nothing;

insert into public.vehicles (
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
    acquisition_notes
) values (
    'NC299450',
    '2T1BURHEXFC299450',
    2015,
    'TOYOTA',
    'COROLLA',
    'S PLUS SEDAN 4D',
    'SUPER WHITE',
    60000,
    '2025-07-04',
    'IN INVENTORY',
    'IN_INVENTORY',
    null,
    null,
    'Imported from All Inventory.xlsx row 28'
) on conflict (vin) do nothing;

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2025-07-04',
    'DIRECT_COST',
    'OTHER_DIRECT_COST',
    20.00,
    'Imported historical direct costs from legacy inventory summary',
    'LEGACY_IMPORT',
    '2T1BURHEXFC299450:other_direct_cost'
from public.vehicles v
where v.vin = '2T1BURHEXFC299450'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'DIRECT_COST'
        and l.category = 'OTHER_DIRECT_COST'
        and l.source_record_id = '2T1BURHEXFC299450:other_direct_cost'
  );

insert into public.vehicles (
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
    acquisition_notes
) values (
    'NCB41118',
    '1FTEW1EP7NFB41118',
    2022,
    'FORD',
    'F150 SUPERCREW CAB',
    'XLT PICKUP 4D 5 1/2 FT',
    'BLUE',
    21348,
    '2025-06-23',
    'SOLD',
    'SOLD',
    '2025-06-23',
    31650.00,
    'Imported from All Inventory.xlsx row 29'
) on conflict (vin) do nothing;

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2025-06-23',
    'ACQUISITION',
    'PURCHASE',
    36425.80,
    'Imported initial purchase cost from legacy inventory summary',
    'LEGACY_IMPORT',
    '1FTEW1EP7NFB41118'
from public.vehicles v
where v.vin = '1FTEW1EP7NFB41118'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'ACQUISITION'
        and l.category = 'PURCHASE'
  );

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2025-06-23',
    'DIRECT_COST',
    'OTHER_DIRECT_COST',
    24.00,
    'Imported historical direct costs from legacy inventory summary',
    'LEGACY_IMPORT',
    '1FTEW1EP7NFB41118:other_direct_cost'
from public.vehicles v
where v.vin = '1FTEW1EP7NFB41118'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'DIRECT_COST'
        and l.category = 'OTHER_DIRECT_COST'
        and l.source_record_id = '1FTEW1EP7NFB41118:other_direct_cost'
  );

insert into public.vehicles (
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
    acquisition_notes
) values (
    'NV003629',
    'JTHHP5AY3JA003629',
    2018,
    'LEXUS',
    'LC',
    'LC 500 COUPE 2D',
    'GRAY',
    45248,
    '2025-09-02',
    'SOLD',
    'SOLD',
    '2025-08-31',
    58500.00,
    'Imported from All Inventory.xlsx row 30'
) on conflict (vin) do nothing;

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2025-09-02',
    'ACQUISITION',
    'PURCHASE',
    55000.00,
    'Imported initial purchase cost from legacy inventory summary',
    'LEGACY_IMPORT',
    'JTHHP5AY3JA003629'
from public.vehicles v
where v.vin = 'JTHHP5AY3JA003629'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'ACQUISITION'
        and l.category = 'PURCHASE'
  );

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2025-09-02',
    'DIRECT_COST',
    'OTHER_DIRECT_COST',
    2409.62,
    'Imported historical direct costs from legacy inventory summary',
    'LEGACY_IMPORT',
    'JTHHP5AY3JA003629:other_direct_cost'
from public.vehicles v
where v.vin = 'JTHHP5AY3JA003629'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'DIRECT_COST'
        and l.category = 'OTHER_DIRECT_COST'
        and l.source_record_id = 'JTHHP5AY3JA003629:other_direct_cost'
  );

insert into public.vehicles (
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
    acquisition_notes
) values (
    'NV019195',
    '7FARS6H53RE019195',
    2024,
    'HONDA',
    'CR-V HYBRID',
    null,
    'SILVER',
    39402,
    '2026-01-30',
    'SOLD',
    'SOLD',
    '2025-04-06',
    27600.00,
    'Imported from All Inventory.xlsx row 31'
) on conflict (vin) do nothing;

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2026-01-30',
    'ACQUISITION',
    'PURCHASE',
    25888.00,
    'Imported initial purchase cost from legacy inventory summary',
    'LEGACY_IMPORT',
    '7FARS6H53RE019195'
from public.vehicles v
where v.vin = '7FARS6H53RE019195'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'ACQUISITION'
        and l.category = 'PURCHASE'
  );

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2026-01-30',
    'DIRECT_COST',
    'OTHER_DIRECT_COST',
    1500.00,
    'Imported historical direct costs from legacy inventory summary',
    'LEGACY_IMPORT',
    '7FARS6H53RE019195:other_direct_cost'
from public.vehicles v
where v.vin = '7FARS6H53RE019195'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'DIRECT_COST'
        and l.category = 'OTHER_DIRECT_COST'
        and l.source_record_id = '7FARS6H53RE019195:other_direct_cost'
  );

insert into public.vehicles (
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
    acquisition_notes
) values (
    'NV081497',
    '3VVAX7B22NM081497',
    2022,
    'VOLKSWAGEN',
    'TAOS',
    'S 4MOTION SPORT UTILITY 4D',
    'WHITE',
    48093,
    '2025-09-04',
    'SOLD',
    'SOLD',
    '2025-09-03',
    19470.00,
    'Imported from All Inventory.xlsx row 32'
) on conflict (vin) do nothing;

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2025-09-04',
    'ACQUISITION',
    'PURCHASE',
    16000.00,
    'Imported initial purchase cost from legacy inventory summary',
    'LEGACY_IMPORT',
    '3VVAX7B22NM081497'
from public.vehicles v
where v.vin = '3VVAX7B22NM081497'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'ACQUISITION'
        and l.category = 'PURCHASE'
  );

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2025-09-04',
    'DIRECT_COST',
    'OTHER_DIRECT_COST',
    1500.00,
    'Imported historical direct costs from legacy inventory summary',
    'LEGACY_IMPORT',
    '3VVAX7B22NM081497:other_direct_cost'
from public.vehicles v
where v.vin = '3VVAX7B22NM081497'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'DIRECT_COST'
        and l.category = 'OTHER_DIRECT_COST'
        and l.source_record_id = '3VVAX7B22NM081497:other_direct_cost'
  );

insert into public.vehicles (
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
    acquisition_notes
) values (
    'NV552281',
    '1C6SRFJT9KN552281',
    2019,
    'RAM',
    '1500 CREW CAB',
    'LARAMIE PICKUP 4D 5 1/2 FT',
    'BLACK',
    56284,
    '2025-03-11',
    'SOLD',
    'SOLD',
    '2025-03-11',
    32000.00,
    'Imported from All Inventory.xlsx row 37'
) on conflict (vin) do nothing;

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2025-03-11',
    'ACQUISITION',
    'PURCHASE',
    29500.00,
    'Imported initial purchase cost from legacy inventory summary',
    'LEGACY_IMPORT',
    '1C6SRFJT9KN552281'
from public.vehicles v
where v.vin = '1C6SRFJT9KN552281'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'ACQUISITION'
        and l.category = 'PURCHASE'
  );

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2025-03-11',
    'DIRECT_COST',
    'OTHER_DIRECT_COST',
    1561.17,
    'Imported historical direct costs from legacy inventory summary',
    'LEGACY_IMPORT',
    '1C6SRFJT9KN552281:other_direct_cost'
from public.vehicles v
where v.vin = '1C6SRFJT9KN552281'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'DIRECT_COST'
        and l.category = 'OTHER_DIRECT_COST'
        and l.source_record_id = '1C6SRFJT9KN552281:other_direct_cost'
  );

insert into public.vehicles (
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
    acquisition_notes
) values (
    'KN092487',
    'WAUV2AF24KN092487',
    2019,
    'AUDI',
    'A7',
    'PRESTIGE SEDAN 4D',
    null,
    27215,
    '2024-02-02',
    'SOLD',
    'SOLD',
    '2024-02-02',
    44000.00,
    'Imported from All Inventory.xlsx row 39'
) on conflict (vin) do nothing;

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2024-02-02',
    'ACQUISITION',
    'PURCHASE',
    42005.00,
    'Imported initial purchase cost from legacy inventory summary',
    'LEGACY_IMPORT',
    'WAUV2AF24KN092487'
from public.vehicles v
where v.vin = 'WAUV2AF24KN092487'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'ACQUISITION'
        and l.category = 'PURCHASE'
  );

insert into public.vehicles (
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
    acquisition_notes
) values (
    'NV869719',
    'WDDWJ8EB0KF869719',
    2019,
    'MERCEDES-BENZ',
    'C-CLASS',
    'C 300 4MATIC COUPE 2D',
    null,
    38169,
    '2024-05-15',
    'SOLD',
    'SOLD',
    '2024-05-15',
    26300.00,
    'Imported from All Inventory.xlsx row 43'
) on conflict (vin) do nothing;

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2024-05-15',
    'ACQUISITION',
    'PURCHASE',
    23800.00,
    'Imported initial purchase cost from legacy inventory summary',
    'LEGACY_IMPORT',
    'WDDWJ8EB0KF869719'
from public.vehicles v
where v.vin = 'WDDWJ8EB0KF869719'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'ACQUISITION'
        and l.category = 'PURCHASE'
  );

insert into public.vehicles (
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
    acquisition_notes
) values (
    'NVP87441',
    '5UXTR9C58KLP87441',
    2019,
    'BMW',
    'X3',
    'XDRIVE30I SPORT UTILITY 4D',
    'SILVER',
    36851,
    '2024-09-21',
    'SOLD',
    'SOLD',
    '2024-09-21',
    22800.00,
    'Imported from All Inventory.xlsx row 45'
) on conflict (vin) do nothing;

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2024-09-21',
    'ACQUISITION',
    'PURCHASE',
    19000.00,
    'Imported initial purchase cost from legacy inventory summary',
    'LEGACY_IMPORT',
    '5UXTR9C58KLP87441'
from public.vehicles v
where v.vin = '5UXTR9C58KLP87441'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'ACQUISITION'
        and l.category = 'PURCHASE'
  );

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2024-09-21',
    'DIRECT_COST',
    'OTHER_DIRECT_COST',
    587.67,
    'Imported historical direct costs from legacy inventory summary',
    'LEGACY_IMPORT',
    '5UXTR9C58KLP87441:other_direct_cost'
from public.vehicles v
where v.vin = '5UXTR9C58KLP87441'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'DIRECT_COST'
        and l.category = 'OTHER_DIRECT_COST'
        and l.source_record_id = '5UXTR9C58KLP87441:other_direct_cost'
  );

insert into public.vehicles (
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
    acquisition_notes
) values (
    'HD005646',
    'WA1LAAF71HD005646',
    2017,
    'AUDI',
    'Q7',
    '3.0T PREMIUM PLUS SPORT UTILITY 4D',
    'BLACK',
    96749,
    '2024-05-07',
    'SOLD',
    'SOLD',
    '2024-05-07',
    12400.00,
    'Imported from All Inventory.xlsx row 46'
) on conflict (vin) do nothing;

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2024-05-07',
    'ACQUISITION',
    'PURCHASE',
    7000.00,
    'Imported initial purchase cost from legacy inventory summary',
    'LEGACY_IMPORT',
    'WA1LAAF71HD005646'
from public.vehicles v
where v.vin = 'WA1LAAF71HD005646'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'ACQUISITION'
        and l.category = 'PURCHASE'
  );

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2024-05-07',
    'DIRECT_COST',
    'OTHER_DIRECT_COST',
    1161.71,
    'Imported historical direct costs from legacy inventory summary',
    'LEGACY_IMPORT',
    'WA1LAAF71HD005646:other_direct_cost'
from public.vehicles v
where v.vin = 'WA1LAAF71HD005646'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'DIRECT_COST'
        and l.category = 'OTHER_DIRECT_COST'
        and l.source_record_id = 'WA1LAAF71HD005646:other_direct_cost'
  );

insert into public.vehicles (
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
    acquisition_notes
) values (
    'NV089543',
    'WA1CCAFP1GA089543',
    2016,
    'AUDI',
    'SQ5',
    'PREMIUM PLUS SPORT UTILITY 4D',
    'GRAY',
    52100,
    '2026-03-03',
    'SOLD',
    'SOLD',
    '2026-03-03',
    17995.00,
    'Imported from All Inventory.xlsx row 47'
) on conflict (vin) do nothing;

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2026-03-03',
    'ACQUISITION',
    'PURCHASE',
    16600.00,
    'Imported initial purchase cost from legacy inventory summary',
    'LEGACY_IMPORT',
    'WA1CCAFP1GA089543'
from public.vehicles v
where v.vin = 'WA1CCAFP1GA089543'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'ACQUISITION'
        and l.category = 'PURCHASE'
  );

insert into public.vehicles (
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
    acquisition_notes
) values (
    'NV142449',
    '5TDYRKECXPS142449',
    2023,
    'TOYOTA',
    'SIENNA',
    'XLE MINIVAN 4D',
    'WHITE',
    44266,
    '2025-04-10',
    'SOLD',
    'SOLD',
    '2025-04-10',
    38725.00,
    'Imported from All Inventory.xlsx row 49'
) on conflict (vin) do nothing;

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2025-04-10',
    'ACQUISITION',
    'PURCHASE',
    38500.00,
    'Imported initial purchase cost from legacy inventory summary',
    'LEGACY_IMPORT',
    '5TDYRKECXPS142449'
from public.vehicles v
where v.vin = '5TDYRKECXPS142449'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'ACQUISITION'
        and l.category = 'PURCHASE'
  );

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2025-04-10',
    'DIRECT_COST',
    'OTHER_DIRECT_COST',
    2.50,
    'Imported historical direct costs from legacy inventory summary',
    'LEGACY_IMPORT',
    '5TDYRKECXPS142449:other_direct_cost'
from public.vehicles v
where v.vin = '5TDYRKECXPS142449'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'DIRECT_COST'
        and l.category = 'OTHER_DIRECT_COST'
        and l.source_record_id = '5TDYRKECXPS142449:other_direct_cost'
  );

insert into public.vehicles (
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
    acquisition_notes
) values (
    'NV213179',
    '2T2HZMDA9LC213179',
    2020,
    'LEXUS',
    'RX',
    'RX 350 SPORT UTILITY 4D',
    'BLUE',
    33634,
    '2024-09-06',
    'SOLD',
    'SOLD',
    '2024-09-06',
    36500.00,
    'Imported from All Inventory.xlsx row 50'
) on conflict (vin) do nothing;

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2024-09-06',
    'ACQUISITION',
    'PURCHASE',
    33600.00,
    'Imported initial purchase cost from legacy inventory summary',
    'LEGACY_IMPORT',
    '2T2HZMDA9LC213179'
from public.vehicles v
where v.vin = '2T2HZMDA9LC213179'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'ACQUISITION'
        and l.category = 'PURCHASE'
  );

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2024-09-06',
    'DIRECT_COST',
    'OTHER_DIRECT_COST',
    459.94,
    'Imported historical direct costs from legacy inventory summary',
    'LEGACY_IMPORT',
    '2T2HZMDA9LC213179:other_direct_cost'
from public.vehicles v
where v.vin = '2T2HZMDA9LC213179'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'DIRECT_COST'
        and l.category = 'OTHER_DIRECT_COST'
        and l.source_record_id = '2T2HZMDA9LC213179:other_direct_cost'
  );

insert into public.vehicles (
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
    acquisition_notes
) values (
    'NV637643',
    '2HKRM4H77DH637643',
    2013,
    'HONDA',
    'CR-V',
    'EX-L SPORT UTILITY 4D',
    'BLACK',
    70921,
    '2025-03-20',
    'SOLD',
    'SOLD',
    '2025-03-20',
    12623.00,
    'Imported from All Inventory.xlsx row 53'
) on conflict (vin) do nothing;

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2025-03-20',
    'ACQUISITION',
    'PURCHASE',
    11500.00,
    'Imported initial purchase cost from legacy inventory summary',
    'LEGACY_IMPORT',
    '2HKRM4H77DH637643'
from public.vehicles v
where v.vin = '2HKRM4H77DH637643'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'ACQUISITION'
        and l.category = 'PURCHASE'
  );

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2025-03-20',
    'DIRECT_COST',
    'OTHER_DIRECT_COST',
    161.30,
    'Imported historical direct costs from legacy inventory summary',
    'LEGACY_IMPORT',
    '2HKRM4H77DH637643:other_direct_cost'
from public.vehicles v
where v.vin = '2HKRM4H77DH637643'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'DIRECT_COST'
        and l.category = 'OTHER_DIRECT_COST'
        and l.source_record_id = '2HKRM4H77DH637643:other_direct_cost'
  );

insert into public.vehicles (
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
    acquisition_notes
) values (
    'NV295478',
    'JTHKD5BH7H2295478',
    2017,
    'LEXUS',
    'CT',
    'CT 200H HATCHBACK 4D',
    'WHITE',
    80818,
    '2024-07-16',
    'SOLD',
    'SOLD',
    '2024-07-16',
    16175.00,
    'Imported from All Inventory.xlsx row 54'
) on conflict (vin) do nothing;

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2024-07-16',
    'ACQUISITION',
    'PURCHASE',
    13600.00,
    'Imported initial purchase cost from legacy inventory summary',
    'LEGACY_IMPORT',
    'JTHKD5BH7H2295478'
from public.vehicles v
where v.vin = 'JTHKD5BH7H2295478'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'ACQUISITION'
        and l.category = 'PURCHASE'
  );

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2024-07-16',
    'DIRECT_COST',
    'OTHER_DIRECT_COST',
    215.00,
    'Imported historical direct costs from legacy inventory summary',
    'LEGACY_IMPORT',
    'JTHKD5BH7H2295478:other_direct_cost'
from public.vehicles v
where v.vin = 'JTHKD5BH7H2295478'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'DIRECT_COST'
        and l.category = 'OTHER_DIRECT_COST'
        and l.source_record_id = 'JTHKD5BH7H2295478:other_direct_cost'
  );

insert into public.vehicles (
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
    acquisition_notes
) values (
    'NV901948',
    'WUAC6AFR6DA901948',
    2013,
    'AUDI',
    'RS 5',
    'COUPE 2D',
    'BLUE',
    96384,
    '2024-05-08',
    'SOLD',
    'SOLD',
    '2024-05-08',
    20995.00,
    'Imported from All Inventory.xlsx row 55'
) on conflict (vin) do nothing;

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2024-05-08',
    'ACQUISITION',
    'PURCHASE',
    11500.00,
    'Imported initial purchase cost from legacy inventory summary',
    'LEGACY_IMPORT',
    'WUAC6AFR6DA901948'
from public.vehicles v
where v.vin = 'WUAC6AFR6DA901948'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'ACQUISITION'
        and l.category = 'PURCHASE'
  );

insert into public.vehicles (
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
    acquisition_notes
) values (
    'NV096939',
    '1HGCV1F31NA096939',
    2022,
    'HONDA',
    'ACCORD',
    'SPORT SEDAN 4D',
    'BLUE',
    19885,
    '2024-06-27',
    'SOLD',
    'SOLD',
    '2024-06-27',
    25000.00,
    'Imported from All Inventory.xlsx row 56'
) on conflict (vin) do nothing;

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2024-06-27',
    'ACQUISITION',
    'PURCHASE',
    21500.00,
    'Imported initial purchase cost from legacy inventory summary',
    'LEGACY_IMPORT',
    '1HGCV1F31NA096939'
from public.vehicles v
where v.vin = '1HGCV1F31NA096939'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'ACQUISITION'
        and l.category = 'PURCHASE'
  );

insert into public.vehicles (
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
    acquisition_notes
) values (
    'NV258223',
    'JTJHY7AX4J4258223',
    2018,
    'LEXUS',
    'LX',
    'LX 570 SPORT UTILITY 4D',
    'WHITE',
    66592,
    '2025-08-22',
    'SOLD',
    'SOLD',
    '2025-08-22',
    51000.00,
    'Imported from All Inventory.xlsx row 57'
) on conflict (vin) do nothing;

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2025-08-22',
    'ACQUISITION',
    'PURCHASE',
    48728.71,
    'Imported initial purchase cost from legacy inventory summary',
    'LEGACY_IMPORT',
    'JTJHY7AX4J4258223'
from public.vehicles v
where v.vin = 'JTJHY7AX4J4258223'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'ACQUISITION'
        and l.category = 'PURCHASE'
  );

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2025-08-22',
    'DIRECT_COST',
    'OTHER_DIRECT_COST',
    1600.00,
    'Imported historical direct costs from legacy inventory summary',
    'LEGACY_IMPORT',
    'JTJHY7AX4J4258223:other_direct_cost'
from public.vehicles v
where v.vin = 'JTJHY7AX4J4258223'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'DIRECT_COST'
        and l.category = 'OTHER_DIRECT_COST'
        and l.source_record_id = 'JTJHY7AX4J4258223:other_direct_cost'
  );

insert into public.vehicles (
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
    acquisition_notes
) values (
    'NV080314',
    '58ABK1GG0JU080314',
    2018,
    'LEXUS',
    'ES',
    'ES 350 SEDAN 4D',
    'GOLD',
    82345,
    '2026-03-12',
    'IN INVENTORY',
    'IN_INVENTORY',
    null,
    null,
    'Imported from All Inventory.xlsx row 59'
) on conflict (vin) do nothing;

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2026-03-12',
    'ACQUISITION',
    'PURCHASE',
    17300.00,
    'Imported initial purchase cost from legacy inventory summary',
    'LEGACY_IMPORT',
    '58ABK1GG0JU080314'
from public.vehicles v
where v.vin = '58ABK1GG0JU080314'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'ACQUISITION'
        and l.category = 'PURCHASE'
  );

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2026-03-12',
    'DIRECT_COST',
    'OTHER_DIRECT_COST',
    10.00,
    'Imported historical direct costs from legacy inventory summary',
    'LEGACY_IMPORT',
    '58ABK1GG0JU080314:other_direct_cost'
from public.vehicles v
where v.vin = '58ABK1GG0JU080314'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'DIRECT_COST'
        and l.category = 'OTHER_DIRECT_COST'
        and l.source_record_id = '58ABK1GG0JU080314:other_direct_cost'
  );

insert into public.vehicles (
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
    acquisition_notes
) values (
    'NV954164',
    '4JGFB4KB6PA954164',
    2023,
    'MERCEDES-BENZ',
    'GLE',
    'GLE 350 4MATIC SPORT UTILITY 4D',
    'BLACK',
    25942,
    '2025-12-30',
    'SOLD',
    'SOLD',
    '2025-12-30',
    45000.00,
    'Imported from All Inventory.xlsx row 60'
) on conflict (vin) do nothing;

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2025-12-30',
    'ACQUISITION',
    'PURCHASE',
    35000.00,
    'Imported initial purchase cost from legacy inventory summary',
    'LEGACY_IMPORT',
    '4JGFB4KB6PA954164'
from public.vehicles v
where v.vin = '4JGFB4KB6PA954164'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'ACQUISITION'
        and l.category = 'PURCHASE'
  );

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2025-12-30',
    'DIRECT_COST',
    'OTHER_DIRECT_COST',
    2550.89,
    'Imported historical direct costs from legacy inventory summary',
    'LEGACY_IMPORT',
    '4JGFB4KB6PA954164:other_direct_cost'
from public.vehicles v
where v.vin = '4JGFB4KB6PA954164'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'DIRECT_COST'
        and l.category = 'OTHER_DIRECT_COST'
        and l.source_record_id = '4JGFB4KB6PA954164:other_direct_cost'
  );

insert into public.vehicles (
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
    acquisition_notes
) values (
    'NVR21538',
    'WBA53FJ03RCR21538',
    2024,
    'BMW',
    '5 SERIES',
    '530I XDRIVE SEDAN 4D',
    'BLUE',
    20383,
    '2025-07-10',
    'SOLD',
    'SOLD',
    '2025-07-10',
    52000.00,
    'Imported from All Inventory.xlsx row 61'
) on conflict (vin) do nothing;

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2025-07-10',
    'ACQUISITION',
    'PURCHASE',
    49105.00,
    'Imported initial purchase cost from legacy inventory summary',
    'LEGACY_IMPORT',
    'WBA53FJ03RCR21538'
from public.vehicles v
where v.vin = 'WBA53FJ03RCR21538'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'ACQUISITION'
        and l.category = 'PURCHASE'
  );

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2025-07-10',
    'DIRECT_COST',
    'OTHER_DIRECT_COST',
    680.00,
    'Imported historical direct costs from legacy inventory summary',
    'LEGACY_IMPORT',
    'WBA53FJ03RCR21538:other_direct_cost'
from public.vehicles v
where v.vin = 'WBA53FJ03RCR21538'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'DIRECT_COST'
        and l.category = 'OTHER_DIRECT_COST'
        and l.source_record_id = 'WBA53FJ03RCR21538:other_direct_cost'
  );

insert into public.vehicles (
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
    acquisition_notes
) values (
    'NV020157',
    '5YJ3E1EA9JF020157',
    2018,
    'TESLA',
    'MODEL 3',
    'LONG RANGE SEDAN 4D',
    'PEARL WHITE MULTI-COAT',
    59212,
    '2025-07-04',
    'IN INVENTORY',
    'IN_INVENTORY',
    null,
    null,
    'Imported from All Inventory.xlsx row 62'
) on conflict (vin) do nothing;

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2025-07-04',
    'DIRECT_COST',
    'OTHER_DIRECT_COST',
    879.00,
    'Imported historical direct costs from legacy inventory summary',
    'LEGACY_IMPORT',
    '5YJ3E1EA9JF020157:other_direct_cost'
from public.vehicles v
where v.vin = '5YJ3E1EA9JF020157'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'DIRECT_COST'
        and l.category = 'OTHER_DIRECT_COST'
        and l.source_record_id = '5YJ3E1EA9JF020157:other_direct_cost'
  );

insert into public.vehicles (
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
    acquisition_notes
) values (
    'TI002821',
    '5J8TB2H27AA002821',
    2010,
    'ACURA',
    'RDX',
    'SPORT UTILITY 4D',
    null,
    167167,
    '2024-07-17',
    'SOLD',
    'SOLD',
    '2024-07-01',
    2300.00,
    'Imported from All Inventory.xlsx row 63'
) on conflict (vin) do nothing;

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2024-07-17',
    'ACQUISITION',
    'PURCHASE',
    1500.00,
    'Imported initial purchase cost from legacy inventory summary',
    'LEGACY_IMPORT',
    '5J8TB2H27AA002821'
from public.vehicles v
where v.vin = '5J8TB2H27AA002821'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'ACQUISITION'
        and l.category = 'PURCHASE'
  );

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2024-07-17',
    'DIRECT_COST',
    'OTHER_DIRECT_COST',
    216.85,
    'Imported historical direct costs from legacy inventory summary',
    'LEGACY_IMPORT',
    '5J8TB2H27AA002821:other_direct_cost'
from public.vehicles v
where v.vin = '5J8TB2H27AA002821'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'DIRECT_COST'
        and l.category = 'OTHER_DIRECT_COST'
        and l.source_record_id = '5J8TB2H27AA002821:other_direct_cost'
  );

insert into public.vehicles (
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
    acquisition_notes
) values (
    'KGV28778',
    'WBA7E4C5XKGV28778',
    2019,
    'BMW',
    '7 SERIES',
    '740I XDRIVE SEDAN 4D',
    'BLACK',
    54080,
    '2023-09-01',
    'SOLD',
    'SOLD',
    '2023-09-01',
    24025.00,
    'Imported from All Inventory.xlsx row 64'
) on conflict (vin) do nothing;

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2023-09-01',
    'ACQUISITION',
    'PURCHASE',
    26685.00,
    'Imported initial purchase cost from legacy inventory summary',
    'LEGACY_IMPORT',
    'WBA7E4C5XKGV28778'
from public.vehicles v
where v.vin = 'WBA7E4C5XKGV28778'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'ACQUISITION'
        and l.category = 'PURCHASE'
  );

insert into public.vehicles (
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
    acquisition_notes
) values (
    'NV949987',
    'YV4062PNXP1949987',
    2023,
    'VOLVO',
    'XC90',
    'B6 PLUS BRIGHT THEME SPORT UTILITY 4D',
    'CRYSTAL WHITE METALLIC',
    5623,
    '2025-10-10',
    'SOLD',
    'SOLD',
    '2025-10-10',
    43000.00,
    'Imported from All Inventory.xlsx row 65'
) on conflict (vin) do nothing;

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2025-10-10',
    'ACQUISITION',
    'PURCHASE',
    42905.00,
    'Imported initial purchase cost from legacy inventory summary',
    'LEGACY_IMPORT',
    'YV4062PNXP1949987'
from public.vehicles v
where v.vin = 'YV4062PNXP1949987'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'ACQUISITION'
        and l.category = 'PURCHASE'
  );

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2025-10-10',
    'DIRECT_COST',
    'OTHER_DIRECT_COST',
    85.92,
    'Imported historical direct costs from legacy inventory summary',
    'LEGACY_IMPORT',
    'YV4062PNXP1949987:other_direct_cost'
from public.vehicles v
where v.vin = 'YV4062PNXP1949987'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'DIRECT_COST'
        and l.category = 'OTHER_DIRECT_COST'
        and l.source_record_id = 'YV4062PNXP1949987:other_direct_cost'
  );

insert into public.vehicles (
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
    acquisition_notes
) values (
    'NVC22434',
    '5UXJU4C05L9C22434',
    2020,
    'BMW',
    'X5',
    'M50I SPORT UTILITY 4D',
    'BLUE',
    36609,
    '2025-09-11',
    'SOLD',
    'SOLD',
    '2025-09-09',
    43000.00,
    'Imported from All Inventory.xlsx row 68'
) on conflict (vin) do nothing;

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2025-09-11',
    'ACQUISITION',
    'PURCHASE',
    36500.00,
    'Imported initial purchase cost from legacy inventory summary',
    'LEGACY_IMPORT',
    '5UXJU4C05L9C22434'
from public.vehicles v
where v.vin = '5UXJU4C05L9C22434'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'ACQUISITION'
        and l.category = 'PURCHASE'
  );

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2025-09-11',
    'DIRECT_COST',
    'OTHER_DIRECT_COST',
    1677.88,
    'Imported historical direct costs from legacy inventory summary',
    'LEGACY_IMPORT',
    '5UXJU4C05L9C22434:other_direct_cost'
from public.vehicles v
where v.vin = '5UXJU4C05L9C22434'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'DIRECT_COST'
        and l.category = 'OTHER_DIRECT_COST'
        and l.source_record_id = '5UXJU4C05L9C22434:other_direct_cost'
  );

insert into public.vehicles (
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
    acquisition_notes
) values (
    'NV402801',
    'W1N4N4HB1NJ402801',
    2022,
    'MERCEDES-BENZ',
    'GLA',
    'GLA 250 4MATIC SPORT UTILITY 4D',
    'WHITE',
    32800,
    '2024-11-21',
    'SOLD',
    'SOLD',
    '2024-11-21',
    26000.00,
    'Imported from All Inventory.xlsx row 71'
) on conflict (vin) do nothing;

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2024-11-21',
    'ACQUISITION',
    'PURCHASE',
    25000.00,
    'Imported initial purchase cost from legacy inventory summary',
    'LEGACY_IMPORT',
    'W1N4N4HB1NJ402801'
from public.vehicles v
where v.vin = 'W1N4N4HB1NJ402801'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'ACQUISITION'
        and l.category = 'PURCHASE'
  );

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2024-11-21',
    'DIRECT_COST',
    'OTHER_DIRECT_COST',
    13.92,
    'Imported historical direct costs from legacy inventory summary',
    'LEGACY_IMPORT',
    'W1N4N4HB1NJ402801:other_direct_cost'
from public.vehicles v
where v.vin = 'W1N4N4HB1NJ402801'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'DIRECT_COST'
        and l.category = 'OTHER_DIRECT_COST'
        and l.source_record_id = 'W1N4N4HB1NJ402801:other_direct_cost'
  );

insert into public.vehicles (
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
    acquisition_notes
) values (
    'NV125769',
    '1G1YB2D42P5125769',
    2023,
    'CHEVROLET',
    'CORVETTE',
    'STINGRAY COUPE 2D',
    'BLUE',
    7356,
    '2025-09-06',
    'SOLD',
    'SOLD',
    '2025-08-31',
    68500.00,
    'Imported from All Inventory.xlsx row 72'
) on conflict (vin) do nothing;

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2025-09-06',
    'ACQUISITION',
    'PURCHASE',
    65000.00,
    'Imported initial purchase cost from legacy inventory summary',
    'LEGACY_IMPORT',
    '1G1YB2D42P5125769'
from public.vehicles v
where v.vin = '1G1YB2D42P5125769'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'ACQUISITION'
        and l.category = 'PURCHASE'
  );

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2025-09-06',
    'DIRECT_COST',
    'OTHER_DIRECT_COST',
    56.03,
    'Imported historical direct costs from legacy inventory summary',
    'LEGACY_IMPORT',
    '1G1YB2D42P5125769:other_direct_cost'
from public.vehicles v
where v.vin = '1G1YB2D42P5125769'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'DIRECT_COST'
        and l.category = 'OTHER_DIRECT_COST'
        and l.source_record_id = '1G1YB2D42P5125769:other_direct_cost'
  );

insert into public.vehicles (
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
    acquisition_notes
) values (
    'NV091908',
    '5TDKRKEC8NS091908',
    2022,
    'TOYOTA',
    'SIENNA',
    'LE MINIVAN 4D',
    'BROWN',
    71871,
    '2024-05-19',
    'SOLD',
    'SOLD',
    '2024-05-19',
    30800.00,
    'Imported from All Inventory.xlsx row 78'
) on conflict (vin) do nothing;

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2024-05-19',
    'ACQUISITION',
    'PURCHASE',
    27600.00,
    'Imported initial purchase cost from legacy inventory summary',
    'LEGACY_IMPORT',
    '5TDKRKEC8NS091908'
from public.vehicles v
where v.vin = '5TDKRKEC8NS091908'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'ACQUISITION'
        and l.category = 'PURCHASE'
  );

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2024-05-19',
    'DIRECT_COST',
    'OTHER_DIRECT_COST',
    702.24,
    'Imported historical direct costs from legacy inventory summary',
    'LEGACY_IMPORT',
    '5TDKRKEC8NS091908:other_direct_cost'
from public.vehicles v
where v.vin = '5TDKRKEC8NS091908'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'DIRECT_COST'
        and l.category = 'OTHER_DIRECT_COST'
        and l.source_record_id = '5TDKRKEC8NS091908:other_direct_cost'
  );

insert into public.vehicles (
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
    acquisition_notes
) values (
    'NV008489',
    'WDD7X6BBXKA008489',
    2019,
    'MERCEDES-BENZ',
    'MERCEDES-AMG GT',
    '53 SEDAN 4D',
    'OBSIDIAN BLACK METALLIC',
    7810,
    '2025-05-30',
    'SOLD',
    'SOLD',
    '2025-05-30',
    61840.00,
    'Imported from All Inventory.xlsx row 81'
) on conflict (vin) do nothing;

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2025-05-30',
    'ACQUISITION',
    'PURCHASE',
    73101.00,
    'Imported initial purchase cost from legacy inventory summary',
    'LEGACY_IMPORT',
    'WDD7X6BBXKA008489'
from public.vehicles v
where v.vin = 'WDD7X6BBXKA008489'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'ACQUISITION'
        and l.category = 'PURCHASE'
  );

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2025-05-30',
    'DIRECT_COST',
    'OTHER_DIRECT_COST',
    493.76,
    'Imported historical direct costs from legacy inventory summary',
    'LEGACY_IMPORT',
    'WDD7X6BBXKA008489:other_direct_cost'
from public.vehicles v
where v.vin = 'WDD7X6BBXKA008489'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'DIRECT_COST'
        and l.category = 'OTHER_DIRECT_COST'
        and l.source_record_id = 'WDD7X6BBXKA008489:other_direct_cost'
  );

insert into public.vehicles (
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
    acquisition_notes
) values (
    'NV180942',
    'WP0CA2A74JL180942',
    2018,
    'PORSCHE',
    'PANAMERA',
    '4 SPORT TURISMO SEDAN 4D',
    'BLACK',
    25133,
    '2026-04-12',
    'SOLD',
    'SOLD',
    '2026-04-12',
    50000.00,
    'Imported from All Inventory.xlsx row 92'
) on conflict (vin) do nothing;

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2026-04-12',
    'ACQUISITION',
    'PURCHASE',
    48500.00,
    'Imported initial purchase cost from legacy inventory summary',
    'LEGACY_IMPORT',
    'WP0CA2A74JL180942'
from public.vehicles v
where v.vin = 'WP0CA2A74JL180942'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'ACQUISITION'
        and l.category = 'PURCHASE'
  );

insert into public.vehicles (
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
    acquisition_notes
) values (
    'NVT35853',
    '5UX23EU07R9T35853',
    2024,
    'BMW',
    'X5',
    'XDRIVE40I SPORT UTILITY 4D',
    null,
    28080,
    '2024-11-16',
    'SOLD',
    'SOLD',
    '2024-11-16',
    49523.86,
    'Imported from All Inventory.xlsx row 94'
) on conflict (vin) do nothing;

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2024-11-16',
    'ACQUISITION',
    'PURCHASE',
    49085.00,
    'Imported initial purchase cost from legacy inventory summary',
    'LEGACY_IMPORT',
    '5UX23EU07R9T35853'
from public.vehicles v
where v.vin = '5UX23EU07R9T35853'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'ACQUISITION'
        and l.category = 'PURCHASE'
  );

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2024-11-16',
    'DIRECT_COST',
    'OTHER_DIRECT_COST',
    1310.45,
    'Imported historical direct costs from legacy inventory summary',
    'LEGACY_IMPORT',
    '5UX23EU07R9T35853:other_direct_cost'
from public.vehicles v
where v.vin = '5UX23EU07R9T35853'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'DIRECT_COST'
        and l.category = 'OTHER_DIRECT_COST'
        and l.source_record_id = '5UX23EU07R9T35853:other_direct_cost'
  );

insert into public.vehicles (
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
    acquisition_notes
) values (
    'NV002127',
    '5J6RW2H88JA002127',
    2018,
    'HONDA',
    'CR-V',
    'EX-L W/NAVIGATION SPORT UTILITY 4D',
    'SILVER',
    56890,
    '2026-02-19',
    'SOLD',
    'SOLD',
    '2026-02-18',
    20000.00,
    'Imported from All Inventory.xlsx row 97'
) on conflict (vin) do nothing;

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2026-02-19',
    'ACQUISITION',
    'PURCHASE',
    18000.00,
    'Imported initial purchase cost from legacy inventory summary',
    'LEGACY_IMPORT',
    '5J6RW2H88JA002127'
from public.vehicles v
where v.vin = '5J6RW2H88JA002127'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'ACQUISITION'
        and l.category = 'PURCHASE'
  );

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2026-02-19',
    'DIRECT_COST',
    'OTHER_DIRECT_COST',
    55.30,
    'Imported historical direct costs from legacy inventory summary',
    'LEGACY_IMPORT',
    '5J6RW2H88JA002127:other_direct_cost'
from public.vehicles v
where v.vin = '5J6RW2H88JA002127'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'DIRECT_COST'
        and l.category = 'OTHER_DIRECT_COST'
        and l.source_record_id = '5J6RW2H88JA002127:other_direct_cost'
  );

insert into public.vehicles (
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
    acquisition_notes
) values (
    'NV038756',
    '2T2BGMCA6KC038756',
    2019,
    'LEXUS',
    'RX',
    'RX 450H SPORT UTILITY 4D',
    null,
    112276,
    '2026-01-26',
    'SOLD',
    'SOLD',
    '2026-01-26',
    22995.00,
    'Imported from All Inventory.xlsx row 98'
) on conflict (vin) do nothing;

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2026-01-26',
    'ACQUISITION',
    'PURCHASE',
    21500.00,
    'Imported initial purchase cost from legacy inventory summary',
    'LEGACY_IMPORT',
    '2T2BGMCA6KC038756'
from public.vehicles v
where v.vin = '2T2BGMCA6KC038756'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'ACQUISITION'
        and l.category = 'PURCHASE'
  );

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2026-01-26',
    'DIRECT_COST',
    'OTHER_DIRECT_COST',
    363.95,
    'Imported historical direct costs from legacy inventory summary',
    'LEGACY_IMPORT',
    '2T2BGMCA6KC038756:other_direct_cost'
from public.vehicles v
where v.vin = '2T2BGMCA6KC038756'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'DIRECT_COST'
        and l.category = 'OTHER_DIRECT_COST'
        and l.source_record_id = '2T2BGMCA6KC038756:other_direct_cost'
  );

insert into public.vehicles (
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
    acquisition_notes
) values (
    'NV124415',
    '5YJYGDEF8MF124415',
    2021,
    'TESLA',
    'MODEL Y',
    'PERFORMANCE SPORT UTILITY 4D',
    'BLACK',
    34000,
    '2024-11-18',
    'SOLD',
    'SOLD',
    '2024-11-20',
    29295.00,
    'Imported from All Inventory.xlsx row 99'
) on conflict (vin) do nothing;

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2024-11-18',
    'ACQUISITION',
    'PURCHASE',
    28500.00,
    'Imported initial purchase cost from legacy inventory summary',
    'LEGACY_IMPORT',
    '5YJYGDEF8MF124415'
from public.vehicles v
where v.vin = '5YJYGDEF8MF124415'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'ACQUISITION'
        and l.category = 'PURCHASE'
  );

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2024-11-18',
    'DIRECT_COST',
    'OTHER_DIRECT_COST',
    155.10,
    'Imported historical direct costs from legacy inventory summary',
    'LEGACY_IMPORT',
    '5YJYGDEF8MF124415:other_direct_cost'
from public.vehicles v
where v.vin = '5YJYGDEF8MF124415'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'DIRECT_COST'
        and l.category = 'OTHER_DIRECT_COST'
        and l.source_record_id = '5YJYGDEF8MF124415:other_direct_cost'
  );

insert into public.vehicles (
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
    acquisition_notes
) values (
    'NV458002',
    'WBAJA7C31HG458002',
    2017,
    'BMW',
    '5 SERIES',
    '530I XDRIVE SEDAN 4D',
    null,
    42857,
    '2024-06-04',
    'SOLD',
    'SOLD',
    '2024-06-04',
    19800.00,
    'Imported from All Inventory.xlsx row 102'
) on conflict (vin) do nothing;

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2024-06-04',
    'ACQUISITION',
    'PURCHASE',
    18100.00,
    'Imported initial purchase cost from legacy inventory summary',
    'LEGACY_IMPORT',
    'WBAJA7C31HG458002'
from public.vehicles v
where v.vin = 'WBAJA7C31HG458002'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'ACQUISITION'
        and l.category = 'PURCHASE'
  );

insert into public.vehicles (
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
    acquisition_notes
) values (
    'TI999058',
    '5YJ3E1ETXSF999058',
    2025,
    'TESLA',
    'MODEL 3',
    'PERFORMANCE SEDAN 4D',
    null,
    15937,
    '2026-03-25',
    'SOLD',
    'SOLD',
    '2026-03-24',
    39500.00,
    'Imported from All Inventory.xlsx row 103'
) on conflict (vin) do nothing;

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2026-03-25',
    'ACQUISITION',
    'PURCHASE',
    30.00,
    'Imported initial purchase cost from legacy inventory summary',
    'LEGACY_IMPORT',
    '5YJ3E1ETXSF999058'
from public.vehicles v
where v.vin = '5YJ3E1ETXSF999058'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'ACQUISITION'
        and l.category = 'PURCHASE'
  );

insert into public.vehicles (
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
    acquisition_notes
) values (
    'NV207594',
    'WA1UFAFL1DA207594',
    2013,
    'AUDI',
    'ALLROAD',
    'PREMIUM PLUS WAGON 4D',
    'WHITE',
    77341,
    '2024-08-08',
    'SOLD',
    'SOLD',
    '2024-08-08',
    16300.00,
    'Imported from All Inventory.xlsx row 105'
) on conflict (vin) do nothing;

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2024-08-08',
    'ACQUISITION',
    'PURCHASE',
    14300.00,
    'Imported initial purchase cost from legacy inventory summary',
    'LEGACY_IMPORT',
    'WA1UFAFL1DA207594'
from public.vehicles v
where v.vin = 'WA1UFAFL1DA207594'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'ACQUISITION'
        and l.category = 'PURCHASE'
  );

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2024-08-08',
    'DIRECT_COST',
    'OTHER_DIRECT_COST',
    1212.21,
    'Imported historical direct costs from legacy inventory summary',
    'LEGACY_IMPORT',
    'WA1UFAFL1DA207594:other_direct_cost'
from public.vehicles v
where v.vin = 'WA1UFAFL1DA207594'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'DIRECT_COST'
        and l.category = 'OTHER_DIRECT_COST'
        and l.source_record_id = 'WA1UFAFL1DA207594:other_direct_cost'
  );

insert into public.vehicles (
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
    acquisition_notes
) values (
    'NV033379',
    'JTHC81D22J5033379',
    2018,
    'LEXUS',
    'IS',
    'IS 300 SEDAN 4D',
    null,
    75005,
    '2024-11-11',
    'SOLD',
    'SOLD',
    '2024-11-11',
    22399.00,
    'Imported from All Inventory.xlsx row 108'
) on conflict (vin) do nothing;

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2024-11-11',
    'ACQUISITION',
    'PURCHASE',
    20500.00,
    'Imported initial purchase cost from legacy inventory summary',
    'LEGACY_IMPORT',
    'JTHC81D22J5033379'
from public.vehicles v
where v.vin = 'JTHC81D22J5033379'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'ACQUISITION'
        and l.category = 'PURCHASE'
  );

insert into public.vehicles (
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
    acquisition_notes
) values (
    'NVH12489',
    'WBA5R7C56KFH12489',
    2019,
    'BMW',
    '3 SERIES',
    '330I XDRIVE SEDAN 4D',
    'WHITE',
    45348,
    '2024-06-13',
    'SOLD',
    'SOLD',
    '2024-06-13',
    23600.00,
    'Imported from All Inventory.xlsx row 111'
) on conflict (vin) do nothing;

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2024-06-13',
    'ACQUISITION',
    'PURCHASE',
    21000.00,
    'Imported initial purchase cost from legacy inventory summary',
    'LEGACY_IMPORT',
    'WBA5R7C56KFH12489'
from public.vehicles v
where v.vin = 'WBA5R7C56KFH12489'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'ACQUISITION'
        and l.category = 'PURCHASE'
  );

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2024-06-13',
    'DIRECT_COST',
    'OTHER_DIRECT_COST',
    24.85,
    'Imported historical direct costs from legacy inventory summary',
    'LEGACY_IMPORT',
    'WBA5R7C56KFH12489:other_direct_cost'
from public.vehicles v
where v.vin = 'WBA5R7C56KFH12489'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'DIRECT_COST'
        and l.category = 'OTHER_DIRECT_COST'
        and l.source_record_id = 'WBA5R7C56KFH12489:other_direct_cost'
  );

insert into public.vehicles (
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
    acquisition_notes
) values (
    'NV002533',
    '5J6RM4H56EL002533',
    2014,
    'HONDA',
    'CR-V',
    'EX SPORT UTILITY 4D',
    'RED',
    93056,
    '2026-01-12',
    'SOLD',
    'SOLD',
    '2026-01-12',
    10495.00,
    'Imported from All Inventory.xlsx row 114'
) on conflict (vin) do nothing;

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2026-01-12',
    'ACQUISITION',
    'PURCHASE',
    9000.00,
    'Imported initial purchase cost from legacy inventory summary',
    'LEGACY_IMPORT',
    '5J6RM4H56EL002533'
from public.vehicles v
where v.vin = '5J6RM4H56EL002533'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'ACQUISITION'
        and l.category = 'PURCHASE'
  );

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2026-01-12',
    'DIRECT_COST',
    'OTHER_DIRECT_COST',
    252.04,
    'Imported historical direct costs from legacy inventory summary',
    'LEGACY_IMPORT',
    '5J6RM4H56EL002533:other_direct_cost'
from public.vehicles v
where v.vin = '5J6RM4H56EL002533'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'DIRECT_COST'
        and l.category = 'OTHER_DIRECT_COST'
        and l.source_record_id = '5J6RM4H56EL002533:other_direct_cost'
  );

insert into public.vehicles (
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
    acquisition_notes
) values (
    'NV342602',
    'WDC0J4KBXJF342602',
    2018,
    'MERCEDES-BENZ',
    'GLC COUPE',
    'GLC 300 4MATIC SPORT UTILITY 4D',
    'WHITE',
    70944,
    '2024-08-20',
    'SOLD',
    'SOLD',
    '2024-08-21',
    27695.00,
    'Imported from All Inventory.xlsx row 119'
) on conflict (vin) do nothing;

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2024-08-20',
    'ACQUISITION',
    'PURCHASE',
    23940.00,
    'Imported initial purchase cost from legacy inventory summary',
    'LEGACY_IMPORT',
    'WDC0J4KBXJF342602'
from public.vehicles v
where v.vin = 'WDC0J4KBXJF342602'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'ACQUISITION'
        and l.category = 'PURCHASE'
  );

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2024-08-20',
    'DIRECT_COST',
    'OTHER_DIRECT_COST',
    37.23,
    'Imported historical direct costs from legacy inventory summary',
    'LEGACY_IMPORT',
    'WDC0J4KBXJF342602:other_direct_cost'
from public.vehicles v
where v.vin = 'WDC0J4KBXJF342602'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'DIRECT_COST'
        and l.category = 'OTHER_DIRECT_COST'
        and l.source_record_id = 'WDC0J4KBXJF342602:other_direct_cost'
  );

insert into public.vehicles (
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
    acquisition_notes
) values (
    'TIS20423',
    'WBA3B5G5XFNS20423',
    2015,
    'BMW',
    '3 SERIES',
    '328I XDRIVE SEDAN 4D',
    'GRAY',
    125044,
    '2025-05-22',
    'SOLD',
    'SOLD',
    '2025-02-27',
    8500.00,
    'Imported from All Inventory.xlsx row 123'
) on conflict (vin) do nothing;

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2025-05-22',
    'ACQUISITION',
    'PURCHASE',
    6700.00,
    'Imported initial purchase cost from legacy inventory summary',
    'LEGACY_IMPORT',
    'WBA3B5G5XFNS20423'
from public.vehicles v
where v.vin = 'WBA3B5G5XFNS20423'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'ACQUISITION'
        and l.category = 'PURCHASE'
  );

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2025-05-22',
    'DIRECT_COST',
    'OTHER_DIRECT_COST',
    811.80,
    'Imported historical direct costs from legacy inventory summary',
    'LEGACY_IMPORT',
    'WBA3B5G5XFNS20423:other_direct_cost'
from public.vehicles v
where v.vin = 'WBA3B5G5XFNS20423'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'DIRECT_COST'
        and l.category = 'OTHER_DIRECT_COST'
        and l.source_record_id = 'WBA3B5G5XFNS20423:other_direct_cost'
  );

insert into public.vehicles (
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
    acquisition_notes
) values (
    'NV521372',
    'WDDZF8KB2KA521372',
    2019,
    'MERCEDES-BENZ',
    'MERCEDES-AMG E-CLASS',
    'E 63 S AMG SEDAN 4D',
    'BLACK',
    50052,
    '2025-04-26',
    'SOLD',
    'SOLD',
    '2025-04-26',
    56225.00,
    'Imported from All Inventory.xlsx row 124'
) on conflict (vin) do nothing;

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2025-04-26',
    'ACQUISITION',
    'PURCHASE',
    51500.00,
    'Imported initial purchase cost from legacy inventory summary',
    'LEGACY_IMPORT',
    'WDDZF8KB2KA521372'
from public.vehicles v
where v.vin = 'WDDZF8KB2KA521372'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'ACQUISITION'
        and l.category = 'PURCHASE'
  );

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2025-04-26',
    'DIRECT_COST',
    'OTHER_DIRECT_COST',
    12.80,
    'Imported historical direct costs from legacy inventory summary',
    'LEGACY_IMPORT',
    'WDDZF8KB2KA521372:other_direct_cost'
from public.vehicles v
where v.vin = 'WDDZF8KB2KA521372'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'DIRECT_COST'
        and l.category = 'OTHER_DIRECT_COST'
        and l.source_record_id = 'WDDZF8KB2KA521372:other_direct_cost'
  );

insert into public.vehicles (
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
    acquisition_notes
) values (
    'NV201362',
    'SHHFK8G78JU201362',
    2018,
    'HONDA',
    'CIVIC TYPE R',
    'TOURING HATCHBACK SEDAN 4D',
    null,
    16730,
    '2025-02-22',
    'SOLD',
    'SOLD',
    '2025-02-22',
    36195.00,
    'Imported from All Inventory.xlsx row 127'
) on conflict (vin) do nothing;

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2025-02-22',
    'ACQUISITION',
    'PURCHASE',
    31000.00,
    'Imported initial purchase cost from legacy inventory summary',
    'LEGACY_IMPORT',
    'SHHFK8G78JU201362'
from public.vehicles v
where v.vin = 'SHHFK8G78JU201362'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'ACQUISITION'
        and l.category = 'PURCHASE'
  );

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2025-02-22',
    'DIRECT_COST',
    'OTHER_DIRECT_COST',
    712.80,
    'Imported historical direct costs from legacy inventory summary',
    'LEGACY_IMPORT',
    'SHHFK8G78JU201362:other_direct_cost'
from public.vehicles v
where v.vin = 'SHHFK8G78JU201362'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'DIRECT_COST'
        and l.category = 'OTHER_DIRECT_COST'
        and l.source_record_id = 'SHHFK8G78JU201362:other_direct_cost'
  );

insert into public.vehicles (
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
    acquisition_notes
) values (
    'N6083111',
    'JTERU5JR7N6083111',
    2022,
    'TOYOTA',
    '4RUNNER',
    'TRD OFF-ROAD PREMIUM SPORT UTILITY 4D',
    null,
    13427,
    '2023-10-06',
    'SOLD',
    'SOLD',
    '2023-09-26',
    42200.00,
    'Imported from All Inventory.xlsx row 128'
) on conflict (vin) do nothing;

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2023-10-06',
    'ACQUISITION',
    'PURCHASE',
    41800.00,
    'Imported initial purchase cost from legacy inventory summary',
    'LEGACY_IMPORT',
    'JTERU5JR7N6083111'
from public.vehicles v
where v.vin = 'JTERU5JR7N6083111'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'ACQUISITION'
        and l.category = 'PURCHASE'
  );

insert into public.vehicles (
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
    acquisition_notes
) values (
    'NV688195',
    '2C3CDZFJ3KH688195',
    2019,
    'DODGE',
    'CHALLENGER',
    'R/T SCAT PACK WIDEBODY COUPE 2D',
    'SILVER',
    29052,
    '2025-09-26',
    'SOLD',
    'SOLD',
    '2025-08-31',
    40500.00,
    'Imported from All Inventory.xlsx row 131'
) on conflict (vin) do nothing;

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2025-09-26',
    'ACQUISITION',
    'PURCHASE',
    37500.00,
    'Imported initial purchase cost from legacy inventory summary',
    'LEGACY_IMPORT',
    '2C3CDZFJ3KH688195'
from public.vehicles v
where v.vin = '2C3CDZFJ3KH688195'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'ACQUISITION'
        and l.category = 'PURCHASE'
  );

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2025-09-26',
    'DIRECT_COST',
    'OTHER_DIRECT_COST',
    358.50,
    'Imported historical direct costs from legacy inventory summary',
    'LEGACY_IMPORT',
    '2C3CDZFJ3KH688195:other_direct_cost'
from public.vehicles v
where v.vin = '2C3CDZFJ3KH688195'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'DIRECT_COST'
        and l.category = 'OTHER_DIRECT_COST'
        and l.source_record_id = '2C3CDZFJ3KH688195:other_direct_cost'
  );

insert into public.vehicles (
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
    acquisition_notes
) values (
    'NV032282',
    '1VWDT7A35HC032282',
    2017,
    'VOLKSWAGEN',
    'PASSAT',
    '1.8T R-LINE SEDAN 4D',
    null,
    45210,
    '2024-10-14',
    'SOLD',
    'SOLD',
    '2024-10-14',
    13920.00,
    'Imported from All Inventory.xlsx row 132'
) on conflict (vin) do nothing;

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2024-10-14',
    'ACQUISITION',
    'PURCHASE',
    13775.00,
    'Imported initial purchase cost from legacy inventory summary',
    'LEGACY_IMPORT',
    '1VWDT7A35HC032282'
from public.vehicles v
where v.vin = '1VWDT7A35HC032282'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'ACQUISITION'
        and l.category = 'PURCHASE'
  );

insert into public.vehicles (
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
    acquisition_notes
) values (
    'NV116716',
    '3MVDMBCL8LM116716',
    2020,
    'MAZDA',
    'CX-30',
    'SELECT SPORT UTILITY 4D',
    'WHITE',
    32158,
    '2024-10-15',
    'SOLD',
    'SOLD',
    '2024-10-15',
    18700.00,
    'Imported from All Inventory.xlsx row 133'
) on conflict (vin) do nothing;

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2024-10-15',
    'ACQUISITION',
    'PURCHASE',
    16000.00,
    'Imported initial purchase cost from legacy inventory summary',
    'LEGACY_IMPORT',
    '3MVDMBCL8LM116716'
from public.vehicles v
where v.vin = '3MVDMBCL8LM116716'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'ACQUISITION'
        and l.category = 'PURCHASE'
  );

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2024-10-15',
    'DIRECT_COST',
    'OTHER_DIRECT_COST',
    181.50,
    'Imported historical direct costs from legacy inventory summary',
    'LEGACY_IMPORT',
    '3MVDMBCL8LM116716:other_direct_cost'
from public.vehicles v
where v.vin = '3MVDMBCL8LM116716'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'DIRECT_COST'
        and l.category = 'OTHER_DIRECT_COST'
        and l.source_record_id = '3MVDMBCL8LM116716:other_direct_cost'
  );

insert into public.vehicles (
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
    acquisition_notes
) values (
    'NV688662',
    '1C4JJXR63MW688662',
    2021,
    'JEEP',
    'WRANGLER UNLIMITED 4XE',
    'RUBICON 4XE SPORT UTILITY 4D',
    'BLACK',
    21298,
    '2024-07-06',
    'SOLD',
    'SOLD',
    '2024-07-06',
    37025.00,
    'Imported from All Inventory.xlsx row 136'
) on conflict (vin) do nothing;

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2024-07-06',
    'ACQUISITION',
    'PURCHASE',
    35500.00,
    'Imported initial purchase cost from legacy inventory summary',
    'LEGACY_IMPORT',
    '1C4JJXR63MW688662'
from public.vehicles v
where v.vin = '1C4JJXR63MW688662'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'ACQUISITION'
        and l.category = 'PURCHASE'
  );

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2024-07-06',
    'DIRECT_COST',
    'OTHER_DIRECT_COST',
    200.00,
    'Imported historical direct costs from legacy inventory summary',
    'LEGACY_IMPORT',
    '1C4JJXR63MW688662:other_direct_cost'
from public.vehicles v
where v.vin = '1C4JJXR63MW688662'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'DIRECT_COST'
        and l.category = 'OTHER_DIRECT_COST'
        and l.source_record_id = '1C4JJXR63MW688662:other_direct_cost'
  );

insert into public.vehicles (
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
    acquisition_notes
) values (
    'NV522788',
    '2HGFC2F61KH522788',
    2019,
    'HONDA',
    'CIVIC',
    'LX SEDAN 4D',
    'GRAY',
    27392,
    '2025-01-04',
    'SOLD',
    'SOLD',
    '2025-01-04',
    16375.00,
    'Imported from All Inventory.xlsx row 139'
) on conflict (vin) do nothing;

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2025-01-04',
    'ACQUISITION',
    'PURCHASE',
    13500.00,
    'Imported initial purchase cost from legacy inventory summary',
    'LEGACY_IMPORT',
    '2HGFC2F61KH522788'
from public.vehicles v
where v.vin = '2HGFC2F61KH522788'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'ACQUISITION'
        and l.category = 'PURCHASE'
  );

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2025-01-04',
    'DIRECT_COST',
    'OTHER_DIRECT_COST',
    109.81,
    'Imported historical direct costs from legacy inventory summary',
    'LEGACY_IMPORT',
    '2HGFC2F61KH522788:other_direct_cost'
from public.vehicles v
where v.vin = '2HGFC2F61KH522788'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'DIRECT_COST'
        and l.category = 'OTHER_DIRECT_COST'
        and l.source_record_id = '2HGFC2F61KH522788:other_direct_cost'
  );

insert into public.vehicles (
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
    acquisition_notes
) values (
    'TI238781',
    '3N1AB8DV3LY238781',
    2020,
    'NISSAN',
    'SENTRA',
    'SR SEDAN 4D',
    'GUN METALLIC',
    76897,
    '2025-06-01',
    'SOLD',
    'SOLD',
    '2025-05-30',
    11891.50,
    'Imported from All Inventory.xlsx row 141'
) on conflict (vin) do nothing;

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2025-06-01',
    'ACQUISITION',
    'PURCHASE',
    9000.00,
    'Imported initial purchase cost from legacy inventory summary',
    'LEGACY_IMPORT',
    '3N1AB8DV3LY238781'
from public.vehicles v
where v.vin = '3N1AB8DV3LY238781'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'ACQUISITION'
        and l.category = 'PURCHASE'
  );

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2025-06-01',
    'DIRECT_COST',
    'OTHER_DIRECT_COST',
    609.46,
    'Imported historical direct costs from legacy inventory summary',
    'LEGACY_IMPORT',
    '3N1AB8DV3LY238781:other_direct_cost'
from public.vehicles v
where v.vin = '3N1AB8DV3LY238781'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'DIRECT_COST'
        and l.category = 'OTHER_DIRECT_COST'
        and l.source_record_id = '3N1AB8DV3LY238781:other_direct_cost'
  );

insert into public.vehicles (
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
    acquisition_notes
) values (
    'NV089543',
    'WA1CCAFP1GA089543',
    2016,
    'AUDI',
    'SQ5',
    'PREMIUM PLUS SPORT UTILITY 4D',
    'GRAY',
    47480,
    '2025-08-20',
    'SOLD',
    'SOLD',
    '2025-08-21',
    19500.00,
    'Imported from All Inventory.xlsx row 143'
) on conflict (vin) do nothing;

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2025-08-20',
    'ACQUISITION',
    'PURCHASE',
    16500.00,
    'Imported initial purchase cost from legacy inventory summary',
    'LEGACY_IMPORT',
    'WA1CCAFP1GA089543'
from public.vehicles v
where v.vin = 'WA1CCAFP1GA089543'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'ACQUISITION'
        and l.category = 'PURCHASE'
  );

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2025-08-20',
    'DIRECT_COST',
    'OTHER_DIRECT_COST',
    30.09,
    'Imported historical direct costs from legacy inventory summary',
    'LEGACY_IMPORT',
    'WA1CCAFP1GA089543:other_direct_cost'
from public.vehicles v
where v.vin = 'WA1CCAFP1GA089543'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'DIRECT_COST'
        and l.category = 'OTHER_DIRECT_COST'
        and l.source_record_id = 'WA1CCAFP1GA089543:other_direct_cost'
  );

insert into public.vehicles (
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
    acquisition_notes
) values (
    'NV048053',
    'WA18NAF40HA048053',
    2017,
    'AUDI',
    'A4 ALLROAD',
    'PREMIUM PLUS WAGON 4D',
    'BLUE',
    102027,
    '2026-02-26',
    'SOLD',
    'SOLD',
    '2026-02-25',
    15295.00,
    'Imported from All Inventory.xlsx row 145'
) on conflict (vin) do nothing;

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2026-02-26',
    'ACQUISITION',
    'PURCHASE',
    12760.00,
    'Imported initial purchase cost from legacy inventory summary',
    'LEGACY_IMPORT',
    'WA18NAF40HA048053'
from public.vehicles v
where v.vin = 'WA18NAF40HA048053'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'ACQUISITION'
        and l.category = 'PURCHASE'
  );

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2026-02-26',
    'DIRECT_COST',
    'OTHER_DIRECT_COST',
    32.99,
    'Imported historical direct costs from legacy inventory summary',
    'LEGACY_IMPORT',
    'WA18NAF40HA048053:other_direct_cost'
from public.vehicles v
where v.vin = 'WA18NAF40HA048053'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'DIRECT_COST'
        and l.category = 'OTHER_DIRECT_COST'
        and l.source_record_id = 'WA18NAF40HA048053:other_direct_cost'
  );

insert into public.vehicles (
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
    acquisition_notes
) values (
    'TI240002',
    '4T4BF1FK4GR240002',
    2016,
    'TOYOTA',
    'CAMRY',
    'LE SEDAN 4D',
    null,
    0,
    '2026-03-20',
    'Trade-In',
    'IN_INVENTORY',
    null,
    null,
    'Imported from All Inventory.xlsx row 148'
) on conflict (vin) do nothing;

insert into public.vehicles (
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
    acquisition_notes
) values (
    'NV506191',
    '2HGFE2F5XNH506191',
    2022,
    'HONDA',
    'CIVIC',
    'SPORT SEDAN 4D',
    'SILVER',
    39844,
    '2026-01-23',
    'IN INVENTORY',
    'IN_INVENTORY',
    null,
    null,
    'Imported from All Inventory.xlsx row 153'
) on conflict (vin) do nothing;

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2026-01-23',
    'ACQUISITION',
    'PURCHASE',
    21689.00,
    'Imported initial purchase cost from legacy inventory summary',
    'LEGACY_IMPORT',
    '2HGFE2F5XNH506191'
from public.vehicles v
where v.vin = '2HGFE2F5XNH506191'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'ACQUISITION'
        and l.category = 'PURCHASE'
  );

insert into public.vehicles (
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
    acquisition_notes
) values (
    'NV852765',
    '5YJ3E1EBXMF852765',
    2021,
    'TESLA',
    'MODEL 3',
    'LONG RANGE SEDAN 4D',
    'BLACK',
    35675,
    '2026-02-21',
    'SOLD',
    'SOLD',
    '2026-02-20',
    24944.00,
    'Imported from All Inventory.xlsx row 157'
) on conflict (vin) do nothing;

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2026-02-21',
    'ACQUISITION',
    'PURCHASE',
    24032.00,
    'Imported initial purchase cost from legacy inventory summary',
    'LEGACY_IMPORT',
    '5YJ3E1EBXMF852765'
from public.vehicles v
where v.vin = '5YJ3E1EBXMF852765'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'ACQUISITION'
        and l.category = 'PURCHASE'
  );

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2026-02-21',
    'DIRECT_COST',
    'OTHER_DIRECT_COST',
    182.15,
    'Imported historical direct costs from legacy inventory summary',
    'LEGACY_IMPORT',
    '5YJ3E1EBXMF852765:other_direct_cost'
from public.vehicles v
where v.vin = '5YJ3E1EBXMF852765'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'DIRECT_COST'
        and l.category = 'OTHER_DIRECT_COST'
        and l.source_record_id = '5YJ3E1EBXMF852765:other_direct_cost'
  );

insert into public.vehicles (
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
    acquisition_notes
) values (
    'NV209412',
    'JN8AT3AB8MW209412',
    2021,
    'NISSAN',
    'ROGUE',
    'S SPORT UTILITY 4D',
    'BLUE',
    18022,
    '2025-01-27',
    'SOLD',
    'SOLD',
    '2025-01-27',
    19500.00,
    'Imported from All Inventory.xlsx row 158'
) on conflict (vin) do nothing;

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2025-01-27',
    'ACQUISITION',
    'PURCHASE',
    16200.00,
    'Imported initial purchase cost from legacy inventory summary',
    'LEGACY_IMPORT',
    'JN8AT3AB8MW209412'
from public.vehicles v
where v.vin = 'JN8AT3AB8MW209412'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'ACQUISITION'
        and l.category = 'PURCHASE'
  );

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2025-01-27',
    'DIRECT_COST',
    'OTHER_DIRECT_COST',
    64.66,
    'Imported historical direct costs from legacy inventory summary',
    'LEGACY_IMPORT',
    'JN8AT3AB8MW209412:other_direct_cost'
from public.vehicles v
where v.vin = 'JN8AT3AB8MW209412'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'DIRECT_COST'
        and l.category = 'OTHER_DIRECT_COST'
        and l.source_record_id = 'JN8AT3AB8MW209412:other_direct_cost'
  );

insert into public.vehicles (
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
    acquisition_notes
) values (
    'NV029176',
    '1HGCV1F30JA029176',
    2018,
    'HONDA',
    'ACCORD',
    'SPORT SEDAN 4D',
    'SILVER',
    64929,
    '2025-08-13',
    'SOLD',
    'SOLD',
    '2025-08-14',
    17975.00,
    'Imported from All Inventory.xlsx row 159'
) on conflict (vin) do nothing;

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2025-08-13',
    'ACQUISITION',
    'PURCHASE',
    17100.00,
    'Imported initial purchase cost from legacy inventory summary',
    'LEGACY_IMPORT',
    '1HGCV1F30JA029176'
from public.vehicles v
where v.vin = '1HGCV1F30JA029176'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'ACQUISITION'
        and l.category = 'PURCHASE'
  );

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2025-08-13',
    'DIRECT_COST',
    'OTHER_DIRECT_COST',
    220.07,
    'Imported historical direct costs from legacy inventory summary',
    'LEGACY_IMPORT',
    '1HGCV1F30JA029176:other_direct_cost'
from public.vehicles v
where v.vin = '1HGCV1F30JA029176'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'DIRECT_COST'
        and l.category = 'OTHER_DIRECT_COST'
        and l.source_record_id = '1HGCV1F30JA029176:other_direct_cost'
  );

insert into public.vehicles (
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
    acquisition_notes
) values (
    'NV400793',
    '5YJ3E1EA7KF400793',
    2019,
    'TESLA',
    'MODEL 3',
    'STANDARD RANGE PLUS SEDAN 4D',
    'BLUE',
    56186,
    '2026-03-12',
    'INBOUND',
    'IN_BOUND',
    null,
    null,
    'Imported from All Inventory.xlsx row 163'
) on conflict (vin) do nothing;

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2026-03-12',
    'ACQUISITION',
    'PURCHASE',
    16300.00,
    'Imported initial purchase cost from legacy inventory summary',
    'LEGACY_IMPORT',
    '5YJ3E1EA7KF400793'
from public.vehicles v
where v.vin = '5YJ3E1EA7KF400793'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'ACQUISITION'
        and l.category = 'PURCHASE'
  );

insert into public.vehicles (
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
    acquisition_notes
) values (
    'M8C07453',
    '3MW5R7J02M8C07453',
    2021,
    'BMW',
    '3 SERIES',
    '330I XDRIVE SEDAN 4D',
    'BLACK',
    42680,
    '2023-09-01',
    'SOLD',
    'SOLD',
    '2023-09-01',
    28032.88,
    'Imported from All Inventory.xlsx row 164'
) on conflict (vin) do nothing;

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2023-09-01',
    'ACQUISITION',
    'PURCHASE',
    28010.00,
    'Imported initial purchase cost from legacy inventory summary',
    'LEGACY_IMPORT',
    '3MW5R7J02M8C07453'
from public.vehicles v
where v.vin = '3MW5R7J02M8C07453'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'ACQUISITION'
        and l.category = 'PURCHASE'
  );

insert into public.vehicles (
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
    acquisition_notes
) values (
    'NV535848',
    'WBA3B3C54DF535848',
    2013,
    'BMW',
    '3 SERIES',
    '328I XDRIVE SEDAN 4D',
    'GRAY',
    70500,
    '2024-12-18',
    'SOLD',
    'SOLD',
    '2024-12-18',
    7788.98,
    'Imported from All Inventory.xlsx row 168'
) on conflict (vin) do nothing;

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2024-12-18',
    'ACQUISITION',
    'PURCHASE',
    5000.00,
    'Imported initial purchase cost from legacy inventory summary',
    'LEGACY_IMPORT',
    'WBA3B3C54DF535848'
from public.vehicles v
where v.vin = 'WBA3B3C54DF535848'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'ACQUISITION'
        and l.category = 'PURCHASE'
  );

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2024-12-18',
    'DIRECT_COST',
    'OTHER_DIRECT_COST',
    268.35,
    'Imported historical direct costs from legacy inventory summary',
    'LEGACY_IMPORT',
    'WBA3B3C54DF535848:other_direct_cost'
from public.vehicles v
where v.vin = 'WBA3B3C54DF535848'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'DIRECT_COST'
        and l.category = 'OTHER_DIRECT_COST'
        and l.source_record_id = 'WBA3B3C54DF535848:other_direct_cost'
  );

insert into public.vehicles (
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
    acquisition_notes
) values (
    'NV174216',
    'WP0AE2A76JL174216',
    2018,
    'PORSCHE',
    'PANAMERA',
    '4 E-HYBRID SEDAN 4D',
    'WHITE',
    29395,
    '2024-05-07',
    'SOLD',
    'SOLD',
    '2024-05-07',
    47158.00,
    'Imported from All Inventory.xlsx row 169'
) on conflict (vin) do nothing;

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2024-05-07',
    'ACQUISITION',
    'PURCHASE',
    45000.00,
    'Imported initial purchase cost from legacy inventory summary',
    'LEGACY_IMPORT',
    'WP0AE2A76JL174216'
from public.vehicles v
where v.vin = 'WP0AE2A76JL174216'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'ACQUISITION'
        and l.category = 'PURCHASE'
  );

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2024-05-07',
    'DIRECT_COST',
    'OTHER_DIRECT_COST',
    115.69,
    'Imported historical direct costs from legacy inventory summary',
    'LEGACY_IMPORT',
    'WP0AE2A76JL174216:other_direct_cost'
from public.vehicles v
where v.vin = 'WP0AE2A76JL174216'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'DIRECT_COST'
        and l.category = 'OTHER_DIRECT_COST'
        and l.source_record_id = 'WP0AE2A76JL174216:other_direct_cost'
  );

insert into public.vehicles (
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
    acquisition_notes
) values (
    'NV603007',
    '2T3DFREV3HW603007',
    2017,
    'TOYOTA',
    'RAV4',
    'LIMITED SPORT UTILITY 4D',
    'SILVER SKY METALLIC',
    115133,
    '2024-12-21',
    'IN INVENTORY',
    'IN_INVENTORY',
    null,
    null,
    'Imported from All Inventory.xlsx row 170'
) on conflict (vin) do nothing;

insert into public.vehicles (
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
    acquisition_notes
) values (
    'NV690187',
    '2HKRW2H93JH690187',
    2018,
    'HONDA',
    'CR-V',
    'TOURING SPORT UTILITY 4D',
    'WHITE',
    61994,
    '2024-11-27',
    'SOLD',
    'SOLD',
    '2024-11-27',
    20999.00,
    'Imported from All Inventory.xlsx row 172'
) on conflict (vin) do nothing;

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2024-11-27',
    'ACQUISITION',
    'PURCHASE',
    19800.00,
    'Imported initial purchase cost from legacy inventory summary',
    'LEGACY_IMPORT',
    '2HKRW2H93JH690187'
from public.vehicles v
where v.vin = '2HKRW2H93JH690187'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'ACQUISITION'
        and l.category = 'PURCHASE'
  );

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2024-11-27',
    'DIRECT_COST',
    'OTHER_DIRECT_COST',
    10.45,
    'Imported historical direct costs from legacy inventory summary',
    'LEGACY_IMPORT',
    '2HKRW2H93JH690187:other_direct_cost'
from public.vehicles v
where v.vin = '2HKRW2H93JH690187'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'DIRECT_COST'
        and l.category = 'OTHER_DIRECT_COST'
        and l.source_record_id = '2HKRW2H93JH690187:other_direct_cost'
  );

insert into public.vehicles (
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
    acquisition_notes
) values (
    'JM704179',
    '3CZRU6H7XJM704179',
    2018,
    'HONDA',
    'HR-V',
    'EX-L W/NAVIGATION SPORT UTILITY 4D',
    'WHITE',
    90976,
    '2024-01-18',
    'SOLD',
    'SOLD',
    '2024-01-18',
    14775.00,
    'Imported from All Inventory.xlsx row 176'
) on conflict (vin) do nothing;

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2024-01-18',
    'ACQUISITION',
    'PURCHASE',
    13600.00,
    'Imported initial purchase cost from legacy inventory summary',
    'LEGACY_IMPORT',
    '3CZRU6H7XJM704179'
from public.vehicles v
where v.vin = '3CZRU6H7XJM704179'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'ACQUISITION'
        and l.category = 'PURCHASE'
  );

insert into public.vehicles (
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
    acquisition_notes
) values (
    'NV037118',
    '2T3G1RFV6KW037118',
    2019,
    'TOYOTA',
    'RAV4',
    'LE SPORT UTILITY 4D',
    null,
    38175,
    '2025-03-29',
    'SOLD',
    'SOLD',
    '2025-03-29',
    22000.00,
    'Imported from All Inventory.xlsx row 179'
) on conflict (vin) do nothing;

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2025-03-29',
    'ACQUISITION',
    'PURCHASE',
    20000.00,
    'Imported initial purchase cost from legacy inventory summary',
    'LEGACY_IMPORT',
    '2T3G1RFV6KW037118'
from public.vehicles v
where v.vin = '2T3G1RFV6KW037118'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'ACQUISITION'
        and l.category = 'PURCHASE'
  );

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2025-03-29',
    'DIRECT_COST',
    'OTHER_DIRECT_COST',
    192.55,
    'Imported historical direct costs from legacy inventory summary',
    'LEGACY_IMPORT',
    '2T3G1RFV6KW037118:other_direct_cost'
from public.vehicles v
where v.vin = '2T3G1RFV6KW037118'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'DIRECT_COST'
        and l.category = 'OTHER_DIRECT_COST'
        and l.source_record_id = '2T3G1RFV6KW037118:other_direct_cost'
  );

insert into public.vehicles (
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
    acquisition_notes
) values (
    'NV023520',
    '5J6RE4H72AL023520',
    2010,
    'HONDA',
    'CR-V',
    'EX-L SPORT UTILITY 4D',
    'GRAY',
    72700,
    '2024-06-20',
    'SOLD',
    'SOLD',
    '2024-06-20',
    9125.00,
    'Imported from All Inventory.xlsx row 180'
) on conflict (vin) do nothing;

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2024-06-20',
    'ACQUISITION',
    'PURCHASE',
    7000.00,
    'Imported initial purchase cost from legacy inventory summary',
    'LEGACY_IMPORT',
    '5J6RE4H72AL023520'
from public.vehicles v
where v.vin = '5J6RE4H72AL023520'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'ACQUISITION'
        and l.category = 'PURCHASE'
  );

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2024-06-20',
    'DIRECT_COST',
    'OTHER_DIRECT_COST',
    216.45,
    'Imported historical direct costs from legacy inventory summary',
    'LEGACY_IMPORT',
    '5J6RE4H72AL023520:other_direct_cost'
from public.vehicles v
where v.vin = '5J6RE4H72AL023520'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'DIRECT_COST'
        and l.category = 'OTHER_DIRECT_COST'
        and l.source_record_id = '5J6RE4H72AL023520:other_direct_cost'
  );

insert into public.vehicles (
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
    acquisition_notes
) values (
    'NVE50929',
    'WBA4W5C54KAE50929',
    2019,
    'BMW',
    '4 SERIES',
    '430I XDRIVE COUPE 2D',
    'BLACK',
    14150,
    '2024-08-22',
    'SOLD',
    'SOLD',
    '2024-08-22',
    25300.00,
    'Imported from All Inventory.xlsx row 181'
) on conflict (vin) do nothing;

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2024-08-22',
    'ACQUISITION',
    'PURCHASE',
    23000.00,
    'Imported initial purchase cost from legacy inventory summary',
    'LEGACY_IMPORT',
    'WBA4W5C54KAE50929'
from public.vehicles v
where v.vin = 'WBA4W5C54KAE50929'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'ACQUISITION'
        and l.category = 'PURCHASE'
  );

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2024-08-22',
    'DIRECT_COST',
    'OTHER_DIRECT_COST',
    87.50,
    'Imported historical direct costs from legacy inventory summary',
    'LEGACY_IMPORT',
    'WBA4W5C54KAE50929:other_direct_cost'
from public.vehicles v
where v.vin = 'WBA4W5C54KAE50929'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'DIRECT_COST'
        and l.category = 'OTHER_DIRECT_COST'
        and l.source_record_id = 'WBA4W5C54KAE50929:other_direct_cost'
  );

insert into public.vehicles (
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
    acquisition_notes
) values (
    'NV196188',
    '5YJYGDEEXMF196188',
    2021,
    'TESLA',
    'MODEL Y',
    'LONG RANGE SPORT UTILITY 4D',
    'WHITE',
    46616,
    '2024-06-30',
    'SOLD',
    'SOLD',
    '2024-06-30',
    30298.50,
    'Imported from All Inventory.xlsx row 187'
) on conflict (vin) do nothing;

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2024-06-30',
    'ACQUISITION',
    'PURCHASE',
    29673.24,
    'Imported initial purchase cost from legacy inventory summary',
    'LEGACY_IMPORT',
    '5YJYGDEEXMF196188'
from public.vehicles v
where v.vin = '5YJYGDEEXMF196188'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'ACQUISITION'
        and l.category = 'PURCHASE'
  );

insert into public.vehicles (
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
    acquisition_notes
) values (
    'NV299450',
    '2T1BURHEXFC299450',
    2015,
    'TOYOTA',
    'COROLLA',
    'S SEDAN 4D',
    'WHITE',
    37512,
    '2025-02-02',
    'SOLD',
    'SOLD',
    '2025-02-02',
    14495.00,
    'Imported from All Inventory.xlsx row 188'
) on conflict (vin) do nothing;

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2025-02-02',
    'ACQUISITION',
    'PURCHASE',
    10700.00,
    'Imported initial purchase cost from legacy inventory summary',
    'LEGACY_IMPORT',
    '2T1BURHEXFC299450'
from public.vehicles v
where v.vin = '2T1BURHEXFC299450'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'ACQUISITION'
        and l.category = 'PURCHASE'
  );

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2025-02-02',
    'DIRECT_COST',
    'OTHER_DIRECT_COST',
    1119.22,
    'Imported historical direct costs from legacy inventory summary',
    'LEGACY_IMPORT',
    '2T1BURHEXFC299450:other_direct_cost'
from public.vehicles v
where v.vin = '2T1BURHEXFC299450'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'DIRECT_COST'
        and l.category = 'OTHER_DIRECT_COST'
        and l.source_record_id = '2T1BURHEXFC299450:other_direct_cost'
  );

insert into public.vehicles (
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
    acquisition_notes
) values (
    'NV185656',
    'SALEW6EU5P2185656',
    2023,
    'LAND ROVER',
    'DEFENDER 90',
    '75TH LIMITED EDITION SPORT UTILITY 2D',
    'GREEN',
    15348,
    '2025-03-03',
    'SOLD',
    'SOLD',
    '2025-03-03',
    61705.00,
    'Imported from All Inventory.xlsx row 195'
) on conflict (vin) do nothing;

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2025-03-03',
    'ACQUISITION',
    'PURCHASE',
    59980.00,
    'Imported initial purchase cost from legacy inventory summary',
    'LEGACY_IMPORT',
    'SALEW6EU5P2185656'
from public.vehicles v
where v.vin = 'SALEW6EU5P2185656'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'ACQUISITION'
        and l.category = 'PURCHASE'
  );

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2025-03-03',
    'DIRECT_COST',
    'OTHER_DIRECT_COST',
    620.56,
    'Imported historical direct costs from legacy inventory summary',
    'LEGACY_IMPORT',
    'SALEW6EU5P2185656:other_direct_cost'
from public.vehicles v
where v.vin = 'SALEW6EU5P2185656'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'DIRECT_COST'
        and l.category = 'OTHER_DIRECT_COST'
        and l.source_record_id = 'SALEW6EU5P2185656:other_direct_cost'
  );

insert into public.vehicles (
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
    acquisition_notes
) values (
    'NC544904',
    'WVGAV3AX7EW544904',
    2014,
    'VOLKSWAGEN',
    'TIGUAN',
    '2.0T SE SPORT UTILITY 4D',
    'REFLEX SILVER METALLIC',
    87112,
    '2025-09-05',
    'SOLD',
    'SOLD',
    '2025-08-24',
    6595.00,
    'Imported from All Inventory.xlsx row 198'
) on conflict (vin) do nothing;

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2025-09-05',
    'ACQUISITION',
    'PURCHASE',
    3968.00,
    'Imported initial purchase cost from legacy inventory summary',
    'LEGACY_IMPORT',
    'WVGAV3AX7EW544904'
from public.vehicles v
where v.vin = 'WVGAV3AX7EW544904'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'ACQUISITION'
        and l.category = 'PURCHASE'
  );

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2025-09-05',
    'DIRECT_COST',
    'OTHER_DIRECT_COST',
    2856.17,
    'Imported historical direct costs from legacy inventory summary',
    'LEGACY_IMPORT',
    'WVGAV3AX7EW544904:other_direct_cost'
from public.vehicles v
where v.vin = 'WVGAV3AX7EW544904'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'DIRECT_COST'
        and l.category = 'OTHER_DIRECT_COST'
        and l.source_record_id = 'WVGAV3AX7EW544904:other_direct_cost'
  );

insert into public.vehicles (
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
    acquisition_notes
) values (
    'NVR55149',
    '5UXCR6C0XP9R55149',
    2023,
    'BMW',
    'X5',
    'XDRIVE40I SPORT UTILITY 4D',
    'BLACK',
    46529,
    '2025-06-04',
    'SOLD',
    'SOLD',
    '2025-06-04',
    46205.00,
    'Imported from All Inventory.xlsx row 199'
) on conflict (vin) do nothing;

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2025-06-04',
    'ACQUISITION',
    'PURCHASE',
    45826.14,
    'Imported initial purchase cost from legacy inventory summary',
    'LEGACY_IMPORT',
    '5UXCR6C0XP9R55149'
from public.vehicles v
where v.vin = '5UXCR6C0XP9R55149'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'ACQUISITION'
        and l.category = 'PURCHASE'
  );

insert into public.vehicles (
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
    acquisition_notes
) values (
    'NC362899',
    'WBSWD9C55AP362899',
    2010,
    'BMW',
    'M3',
    'COUPE 2D',
    'BLACK',
    81963,
    '2025-07-18',
    'SOLD',
    'SOLD',
    '2025-07-18',
    19080.00,
    'Imported from All Inventory.xlsx row 200'
) on conflict (vin) do nothing;

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2025-07-18',
    'ACQUISITION',
    'PURCHASE',
    25000.00,
    'Imported initial purchase cost from legacy inventory summary',
    'LEGACY_IMPORT',
    'WBSWD9C55AP362899'
from public.vehicles v
where v.vin = 'WBSWD9C55AP362899'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'ACQUISITION'
        and l.category = 'PURCHASE'
  );

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2025-07-18',
    'DIRECT_COST',
    'OTHER_DIRECT_COST',
    240.00,
    'Imported historical direct costs from legacy inventory summary',
    'LEGACY_IMPORT',
    'WBSWD9C55AP362899:other_direct_cost'
from public.vehicles v
where v.vin = 'WBSWD9C55AP362899'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'DIRECT_COST'
        and l.category = 'OTHER_DIRECT_COST'
        and l.source_record_id = 'WBSWD9C55AP362899:other_direct_cost'
  );

insert into public.vehicles (
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
    acquisition_notes
) values (
    'NVT75100',
    '5UX23EU04R9T75100',
    2024,
    'BMW',
    'X5',
    'XDRIVE40I SPORT UTILITY 4D',
    'WHITE',
    30240,
    '2025-04-11',
    'SOLD',
    'SOLD',
    '2024-11-13',
    51925.00,
    'Imported from All Inventory.xlsx row 206'
) on conflict (vin) do nothing;

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2025-04-11',
    'ACQUISITION',
    'PURCHASE',
    47500.00,
    'Imported initial purchase cost from legacy inventory summary',
    'LEGACY_IMPORT',
    '5UX23EU04R9T75100'
from public.vehicles v
where v.vin = '5UX23EU04R9T75100'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'ACQUISITION'
        and l.category = 'PURCHASE'
  );

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2025-04-11',
    'DIRECT_COST',
    'OTHER_DIRECT_COST',
    1323.63,
    'Imported historical direct costs from legacy inventory summary',
    'LEGACY_IMPORT',
    '5UX23EU04R9T75100:other_direct_cost'
from public.vehicles v
where v.vin = '5UX23EU04R9T75100'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'DIRECT_COST'
        and l.category = 'OTHER_DIRECT_COST'
        and l.source_record_id = '5UX23EU04R9T75100:other_direct_cost'
  );

insert into public.vehicles (
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
    acquisition_notes
) values (
    'NV557728',
    'JM1NDAL71P0557728',
    2023,
    'MAZDA',
    'MX-5 MIATA RF',
    'CLUB W/BREMBO BBS RECARO PKG CONVERTIBLE 2D',
    null,
    1360,
    '2024-08-07',
    'SOLD',
    'SOLD',
    '2024-08-07',
    34500.00,
    'Imported from All Inventory.xlsx row 207'
) on conflict (vin) do nothing;

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2024-08-07',
    'ACQUISITION',
    'PURCHASE',
    32000.00,
    'Imported initial purchase cost from legacy inventory summary',
    'LEGACY_IMPORT',
    'JM1NDAL71P0557728'
from public.vehicles v
where v.vin = 'JM1NDAL71P0557728'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'ACQUISITION'
        and l.category = 'PURCHASE'
  );

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2024-08-07',
    'DIRECT_COST',
    'OTHER_DIRECT_COST',
    13.26,
    'Imported historical direct costs from legacy inventory summary',
    'LEGACY_IMPORT',
    'JM1NDAL71P0557728:other_direct_cost'
from public.vehicles v
where v.vin = 'JM1NDAL71P0557728'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'DIRECT_COST'
        and l.category = 'OTHER_DIRECT_COST'
        and l.source_record_id = 'JM1NDAL71P0557728:other_direct_cost'
  );

insert into public.vehicles (
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
    acquisition_notes
) values (
    'NV597633',
    'ZARFAEEN8J7597633',
    2018,
    'ALFA ROMEO',
    'GIULIA',
    'TI SPORT SEDAN 4D',
    'BLACK',
    50745,
    '2024-05-05',
    'SOLD',
    'SOLD',
    '2024-05-05',
    20305.00,
    'Imported from All Inventory.xlsx row 209'
) on conflict (vin) do nothing;

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2024-05-05',
    'ACQUISITION',
    'PURCHASE',
    13000.00,
    'Imported initial purchase cost from legacy inventory summary',
    'LEGACY_IMPORT',
    'ZARFAEEN8J7597633'
from public.vehicles v
where v.vin = 'ZARFAEEN8J7597633'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'ACQUISITION'
        and l.category = 'PURCHASE'
  );

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2024-05-05',
    'DIRECT_COST',
    'OTHER_DIRECT_COST',
    1091.07,
    'Imported historical direct costs from legacy inventory summary',
    'LEGACY_IMPORT',
    'ZARFAEEN8J7597633:other_direct_cost'
from public.vehicles v
where v.vin = 'ZARFAEEN8J7597633'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'DIRECT_COST'
        and l.category = 'OTHER_DIRECT_COST'
        and l.source_record_id = 'ZARFAEEN8J7597633:other_direct_cost'
  );

insert into public.vehicles (
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
    acquisition_notes
) values (
    'NV261257',
    'ZFF98RNA6M0261257',
    2021,
    'FERRARI',
    'ROMA',
    'COUPE 2D',
    null,
    12326,
    '2026-03-09',
    'IN INVENTORY',
    'IN_INVENTORY',
    null,
    null,
    'Imported from All Inventory.xlsx row 211'
) on conflict (vin) do nothing;

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2026-03-09',
    'ACQUISITION',
    'PURCHASE',
    177900.00,
    'Imported initial purchase cost from legacy inventory summary',
    'LEGACY_IMPORT',
    'ZFF98RNA6M0261257'
from public.vehicles v
where v.vin = 'ZFF98RNA6M0261257'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'ACQUISITION'
        and l.category = 'PURCHASE'
  );

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2026-03-09',
    'DIRECT_COST',
    'OTHER_DIRECT_COST',
    423.60,
    'Imported historical direct costs from legacy inventory summary',
    'LEGACY_IMPORT',
    'ZFF98RNA6M0261257:other_direct_cost'
from public.vehicles v
where v.vin = 'ZFF98RNA6M0261257'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'DIRECT_COST'
        and l.category = 'OTHER_DIRECT_COST'
        and l.source_record_id = 'ZFF98RNA6M0261257:other_direct_cost'
  );

insert into public.vehicles (
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
    acquisition_notes
) values (
    'NV067591',
    '1HGCV1F14KA067591',
    2019,
    'HONDA',
    'ACCORD',
    'LX SEDAN 4D',
    'WHITE',
    78546,
    '2026-02-19',
    'SOLD',
    'SOLD',
    '2026-02-18',
    15875.00,
    'Imported from All Inventory.xlsx row 212'
) on conflict (vin) do nothing;

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2026-02-19',
    'ACQUISITION',
    'PURCHASE',
    13500.00,
    'Imported initial purchase cost from legacy inventory summary',
    'LEGACY_IMPORT',
    '1HGCV1F14KA067591'
from public.vehicles v
where v.vin = '1HGCV1F14KA067591'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'ACQUISITION'
        and l.category = 'PURCHASE'
  );

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2026-02-19',
    'DIRECT_COST',
    'OTHER_DIRECT_COST',
    462.35,
    'Imported historical direct costs from legacy inventory summary',
    'LEGACY_IMPORT',
    '1HGCV1F14KA067591:other_direct_cost'
from public.vehicles v
where v.vin = '1HGCV1F14KA067591'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'DIRECT_COST'
        and l.category = 'OTHER_DIRECT_COST'
        and l.source_record_id = '1HGCV1F14KA067591:other_direct_cost'
  );

insert into public.vehicles (
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
    acquisition_notes
) values (
    'NV078819',
    'NMTKHMBXXKR078819',
    2019,
    'TOYOTA',
    'C-HR',
    'LE SPORT UTILITY 4D',
    'GRAY',
    63754,
    '2024-05-15',
    'SOLD',
    'SOLD',
    '2024-05-15',
    13375.00,
    'Imported from All Inventory.xlsx row 213'
) on conflict (vin) do nothing;

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2024-05-15',
    'ACQUISITION',
    'PURCHASE',
    14300.00,
    'Imported initial purchase cost from legacy inventory summary',
    'LEGACY_IMPORT',
    'NMTKHMBXXKR078819'
from public.vehicles v
where v.vin = 'NMTKHMBXXKR078819'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'ACQUISITION'
        and l.category = 'PURCHASE'
  );

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2024-05-15',
    'DIRECT_COST',
    'OTHER_DIRECT_COST',
    46.90,
    'Imported historical direct costs from legacy inventory summary',
    'LEGACY_IMPORT',
    'NMTKHMBXXKR078819:other_direct_cost'
from public.vehicles v
where v.vin = 'NMTKHMBXXKR078819'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'DIRECT_COST'
        and l.category = 'OTHER_DIRECT_COST'
        and l.source_record_id = 'NMTKHMBXXKR078819:other_direct_cost'
  );

insert into public.vehicles (
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
    acquisition_notes
) values (
    'NV025325',
    '5FNYF5H21NB025325',
    2022,
    'HONDA',
    'PILOT',
    'SPECIAL EDITION SPORT UTILITY 4D',
    null,
    53852,
    '2025-01-13',
    'SOLD',
    'SOLD',
    '2025-01-13',
    26886.00,
    'Imported from All Inventory.xlsx row 215'
) on conflict (vin) do nothing;

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2025-01-13',
    'ACQUISITION',
    'PURCHASE',
    24000.00,
    'Imported initial purchase cost from legacy inventory summary',
    'LEGACY_IMPORT',
    '5FNYF5H21NB025325'
from public.vehicles v
where v.vin = '5FNYF5H21NB025325'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'ACQUISITION'
        and l.category = 'PURCHASE'
  );

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2025-01-13',
    'DIRECT_COST',
    'OTHER_DIRECT_COST',
    17.79,
    'Imported historical direct costs from legacy inventory summary',
    'LEGACY_IMPORT',
    '5FNYF5H21NB025325:other_direct_cost'
from public.vehicles v
where v.vin = '5FNYF5H21NB025325'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'DIRECT_COST'
        and l.category = 'OTHER_DIRECT_COST'
        and l.source_record_id = '5FNYF5H21NB025325:other_direct_cost'
  );

insert into public.vehicles (
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
    acquisition_notes
) values (
    'NV112409',
    'WP0AA2A7XJL112409',
    2018,
    'PORSCHE',
    'PANAMERA',
    '4 SEDAN 4D',
    'GREY',
    37412,
    '2024-05-15',
    'SOLD',
    'SOLD',
    '2024-05-15',
    45000.00,
    'Imported from All Inventory.xlsx row 216'
) on conflict (vin) do nothing;

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2024-05-15',
    'ACQUISITION',
    'PURCHASE',
    40500.00,
    'Imported initial purchase cost from legacy inventory summary',
    'LEGACY_IMPORT',
    'WP0AA2A7XJL112409'
from public.vehicles v
where v.vin = 'WP0AA2A7XJL112409'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'ACQUISITION'
        and l.category = 'PURCHASE'
  );

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2024-05-15',
    'DIRECT_COST',
    'OTHER_DIRECT_COST',
    1030.00,
    'Imported historical direct costs from legacy inventory summary',
    'LEGACY_IMPORT',
    'WP0AA2A7XJL112409:other_direct_cost'
from public.vehicles v
where v.vin = 'WP0AA2A7XJL112409'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'DIRECT_COST'
        and l.category = 'OTHER_DIRECT_COST'
        and l.source_record_id = 'WP0AA2A7XJL112409:other_direct_cost'
  );

insert into public.vehicles (
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
    acquisition_notes
) values (
    'JA037417',
    'WAUB4CF54JA037417',
    2018,
    'AUDI',
    'S5',
    'PREMIUM PLUS SEDAN 4D',
    'SILVER',
    61984,
    '2024-04-12',
    'SOLD',
    'SOLD',
    '2024-04-09',
    25000.00,
    'Imported from All Inventory.xlsx row 219'
) on conflict (vin) do nothing;

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2024-04-12',
    'ACQUISITION',
    'PURCHASE',
    24000.00,
    'Imported initial purchase cost from legacy inventory summary',
    'LEGACY_IMPORT',
    'WAUB4CF54JA037417'
from public.vehicles v
where v.vin = 'WAUB4CF54JA037417'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'ACQUISITION'
        and l.category = 'PURCHASE'
  );

insert into public.vehicles (
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
    acquisition_notes
) values (
    'H0134456',
    '1G1FB1RX0H0134456',
    2017,
    'CHEVROLET',
    'CAMARO',
    'LT COUPE 2D',
    'RED',
    47765,
    '2024-01-05',
    'SOLD',
    'SOLD',
    '2024-01-05',
    16000.00,
    'Imported from All Inventory.xlsx row 221'
) on conflict (vin) do nothing;

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2024-01-05',
    'ACQUISITION',
    'PURCHASE',
    15250.00,
    'Imported initial purchase cost from legacy inventory summary',
    'LEGACY_IMPORT',
    '1G1FB1RX0H0134456'
from public.vehicles v
where v.vin = '1G1FB1RX0H0134456'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'ACQUISITION'
        and l.category = 'PURCHASE'
  );

insert into public.vehicles (
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
    acquisition_notes
) values (
    'NV610831',
    'JF1ZCAC13D1610831',
    2013,
    'SUBARU',
    'BRZ',
    'LIMITED COUPE 2D',
    null,
    77849,
    '2026-04-06',
    'SOLD',
    'SOLD',
    '2026-04-06',
    12495.00,
    'Imported from All Inventory.xlsx row 222'
) on conflict (vin) do nothing;

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2026-04-06',
    'DIRECT_COST',
    'OTHER_DIRECT_COST',
    164.50,
    'Imported historical direct costs from legacy inventory summary',
    'LEGACY_IMPORT',
    'JF1ZCAC13D1610831:other_direct_cost'
from public.vehicles v
where v.vin = 'JF1ZCAC13D1610831'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'DIRECT_COST'
        and l.category = 'OTHER_DIRECT_COST'
        and l.source_record_id = 'JF1ZCAC13D1610831:other_direct_cost'
  );

insert into public.vehicles (
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
    acquisition_notes
) values (
    'NV493594',
    '1N4AL2AP7CN493594',
    2012,
    'NISSAN',
    'ALTIMA',
    '2.5 S SEDAN 4D',
    'BLACK',
    88894,
    '2024-08-13',
    'SOLD',
    'SOLD',
    '2024-08-13',
    3400.00,
    'Imported from All Inventory.xlsx row 223'
) on conflict (vin) do nothing;

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2024-08-13',
    'ACQUISITION',
    'PURCHASE',
    2500.00,
    'Imported initial purchase cost from legacy inventory summary',
    'LEGACY_IMPORT',
    '1N4AL2AP7CN493594'
from public.vehicles v
where v.vin = '1N4AL2AP7CN493594'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'ACQUISITION'
        and l.category = 'PURCHASE'
  );

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2024-08-13',
    'DIRECT_COST',
    'OTHER_DIRECT_COST',
    1302.27,
    'Imported historical direct costs from legacy inventory summary',
    'LEGACY_IMPORT',
    '1N4AL2AP7CN493594:other_direct_cost'
from public.vehicles v
where v.vin = '1N4AL2AP7CN493594'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'DIRECT_COST'
        and l.category = 'OTHER_DIRECT_COST'
        and l.source_record_id = '1N4AL2AP7CN493594:other_direct_cost'
  );

insert into public.vehicles (
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
    acquisition_notes
) values (
    'NV362899',
    'WBSWD9C55AP362899',
    2010,
    'BMW',
    'M3',
    'COUPE 2D',
    'BLACK',
    77370,
    '2025-04-04',
    'SOLD',
    'SOLD',
    '2025-04-04',
    30305.00,
    'Imported from All Inventory.xlsx row 228'
) on conflict (vin) do nothing;

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2025-04-04',
    'DIRECT_COST',
    'OTHER_DIRECT_COST',
    350.20,
    'Imported historical direct costs from legacy inventory summary',
    'LEGACY_IMPORT',
    'WBSWD9C55AP362899:other_direct_cost'
from public.vehicles v
where v.vin = 'WBSWD9C55AP362899'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'DIRECT_COST'
        and l.category = 'OTHER_DIRECT_COST'
        and l.source_record_id = 'WBSWD9C55AP362899:other_direct_cost'
  );

insert into public.vehicles (
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
    acquisition_notes
) values (
    'NV422923',
    '7SAXCDE58PF422923',
    2023,
    'TESLA',
    'MODEL X',
    'STANDARD SPORT UTILITY 4D',
    'GRAY',
    48870,
    '2026-04-17',
    'IN INVENTORY',
    'IN_INVENTORY',
    null,
    null,
    'Imported from All Inventory.xlsx row 229'
) on conflict (vin) do nothing;

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2026-04-17',
    'ACQUISITION',
    'PURCHASE',
    50375.00,
    'Imported initial purchase cost from legacy inventory summary',
    'LEGACY_IMPORT',
    '7SAXCDE58PF422923'
from public.vehicles v
where v.vin = '7SAXCDE58PF422923'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'ACQUISITION'
        and l.category = 'PURCHASE'
  );

insert into public.vehicles (
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
    acquisition_notes
) values (
    'NVD00549',
    '1FTFW1RG7JFD00549',
    2018,
    'FORD',
    'F150 SUPERCREW CAB',
    'RAPTOR PICKUP 4D 5 1/2 FT',
    'GRAY',
    107917,
    '2026-03-02',
    'SOLD',
    'SOLD',
    '2026-03-02',
    32200.00,
    'Imported from All Inventory.xlsx row 230'
) on conflict (vin) do nothing;

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2026-03-02',
    'ACQUISITION',
    'PURCHASE',
    29162.38,
    'Imported initial purchase cost from legacy inventory summary',
    'LEGACY_IMPORT',
    '1FTFW1RG7JFD00549'
from public.vehicles v
where v.vin = '1FTFW1RG7JFD00549'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'ACQUISITION'
        and l.category = 'PURCHASE'
  );

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2026-03-02',
    'DIRECT_COST',
    'OTHER_DIRECT_COST',
    170.96,
    'Imported historical direct costs from legacy inventory summary',
    'LEGACY_IMPORT',
    '1FTFW1RG7JFD00549:other_direct_cost'
from public.vehicles v
where v.vin = '1FTFW1RG7JFD00549'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'DIRECT_COST'
        and l.category = 'OTHER_DIRECT_COST'
        and l.source_record_id = '1FTFW1RG7JFD00549:other_direct_cost'
  );

insert into public.vehicles (
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
    acquisition_notes
) values (
    'MU007140',
    '58ADA1C10MU007140',
    2021,
    'LEXUS',
    'ES',
    'ES 300H SEDAN 4D',
    'WHITE',
    15432,
    '2024-01-05',
    'SOLD',
    'SOLD',
    '2024-01-05',
    36200.00,
    'Imported from All Inventory.xlsx row 232'
) on conflict (vin) do nothing;

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2024-01-05',
    'ACQUISITION',
    'PURCHASE',
    34213.07,
    'Imported initial purchase cost from legacy inventory summary',
    'LEGACY_IMPORT',
    '58ADA1C10MU007140'
from public.vehicles v
where v.vin = '58ADA1C10MU007140'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'ACQUISITION'
        and l.category = 'PURCHASE'
  );

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2024-01-05',
    'DIRECT_COST',
    'OTHER_DIRECT_COST',
    100.00,
    'Imported historical direct costs from legacy inventory summary',
    'LEGACY_IMPORT',
    '58ADA1C10MU007140:other_direct_cost'
from public.vehicles v
where v.vin = '58ADA1C10MU007140'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'DIRECT_COST'
        and l.category = 'OTHER_DIRECT_COST'
        and l.source_record_id = '58ADA1C10MU007140:other_direct_cost'
  );

insert into public.vehicles (
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
    acquisition_notes
) values (
    'NV034324',
    'JTNKHMBX2K1034324',
    2019,
    'TOYOTA',
    'C-HR',
    'XLE SPORT UTILITY 4D',
    'GRAY',
    61015,
    '2026-01-28',
    'SOLD',
    'SOLD',
    '2026-01-28',
    13175.00,
    'Imported from All Inventory.xlsx row 235'
) on conflict (vin) do nothing;

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2026-01-28',
    'ACQUISITION',
    'PURCHASE',
    11500.00,
    'Imported initial purchase cost from legacy inventory summary',
    'LEGACY_IMPORT',
    'JTNKHMBX2K1034324'
from public.vehicles v
where v.vin = 'JTNKHMBX2K1034324'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'ACQUISITION'
        and l.category = 'PURCHASE'
  );

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2026-01-28',
    'DIRECT_COST',
    'OTHER_DIRECT_COST',
    1500.00,
    'Imported historical direct costs from legacy inventory summary',
    'LEGACY_IMPORT',
    'JTNKHMBX2K1034324:other_direct_cost'
from public.vehicles v
where v.vin = 'JTNKHMBX2K1034324'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'DIRECT_COST'
        and l.category = 'OTHER_DIRECT_COST'
        and l.source_record_id = 'JTNKHMBX2K1034324:other_direct_cost'
  );

insert into public.vehicles (
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
    acquisition_notes
) values (
    'NV114650',
    'WF0DP3TH4G4114650',
    2016,
    'FORD',
    'FOCUS',
    'RS HATCHBACK 4D',
    'BLUE',
    38587,
    '2025-05-03',
    'SOLD',
    'SOLD',
    '2025-05-03',
    29895.00,
    'Imported from All Inventory.xlsx row 236'
) on conflict (vin) do nothing;

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2025-05-03',
    'ACQUISITION',
    'PURCHASE',
    27200.00,
    'Imported initial purchase cost from legacy inventory summary',
    'LEGACY_IMPORT',
    'WF0DP3TH4G4114650'
from public.vehicles v
where v.vin = 'WF0DP3TH4G4114650'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'ACQUISITION'
        and l.category = 'PURCHASE'
  );

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2025-05-03',
    'DIRECT_COST',
    'OTHER_DIRECT_COST',
    302.88,
    'Imported historical direct costs from legacy inventory summary',
    'LEGACY_IMPORT',
    'WF0DP3TH4G4114650:other_direct_cost'
from public.vehicles v
where v.vin = 'WF0DP3TH4G4114650'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'DIRECT_COST'
        and l.category = 'OTHER_DIRECT_COST'
        and l.source_record_id = 'WF0DP3TH4G4114650:other_direct_cost'
  );

insert into public.vehicles (
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
    acquisition_notes
) values (
    'NV403226',
    'JM1FE172490403226',
    2009,
    'MAZDA',
    'RX-8',
    'GRAND TOURING COUPE 4D',
    'RED',
    77013,
    '2025-08-20',
    'SOLD',
    'SOLD',
    '2025-08-20',
    10500.00,
    'Imported from All Inventory.xlsx row 237'
) on conflict (vin) do nothing;

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2025-08-20',
    'ACQUISITION',
    'PURCHASE',
    9500.00,
    'Imported initial purchase cost from legacy inventory summary',
    'LEGACY_IMPORT',
    'JM1FE172490403226'
from public.vehicles v
where v.vin = 'JM1FE172490403226'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'ACQUISITION'
        and l.category = 'PURCHASE'
  );

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2025-08-20',
    'DIRECT_COST',
    'OTHER_DIRECT_COST',
    261.80,
    'Imported historical direct costs from legacy inventory summary',
    'LEGACY_IMPORT',
    'JM1FE172490403226:other_direct_cost'
from public.vehicles v
where v.vin = 'JM1FE172490403226'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'DIRECT_COST'
        and l.category = 'OTHER_DIRECT_COST'
        and l.source_record_id = 'JM1FE172490403226:other_direct_cost'
  );

insert into public.vehicles (
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
    acquisition_notes
) values (
    'EC524742',
    '5N1AL0MM7EC524742',
    2014,
    'INFINITI',
    'QX60',
    '3.5 SPORT UTILITY 4D',
    null,
    150687,
    '2023-12-08',
    'SOLD',
    'SOLD',
    '2023-12-08',
    1935.00,
    'Imported from All Inventory.xlsx row 238'
) on conflict (vin) do nothing;

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2023-12-08',
    'ACQUISITION',
    'PURCHASE',
    1000.00,
    'Imported initial purchase cost from legacy inventory summary',
    'LEGACY_IMPORT',
    '5N1AL0MM7EC524742'
from public.vehicles v
where v.vin = '5N1AL0MM7EC524742'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'ACQUISITION'
        and l.category = 'PURCHASE'
  );

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2023-12-08',
    'DIRECT_COST',
    'OTHER_DIRECT_COST',
    960.00,
    'Imported historical direct costs from legacy inventory summary',
    'LEGACY_IMPORT',
    '5N1AL0MM7EC524742:other_direct_cost'
from public.vehicles v
where v.vin = '5N1AL0MM7EC524742'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'DIRECT_COST'
        and l.category = 'OTHER_DIRECT_COST'
        and l.source_record_id = '5N1AL0MM7EC524742:other_direct_cost'
  );

insert into public.vehicles (
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
    acquisition_notes
) values (
    'NV689580',
    'WBA8A3C56GK689580',
    2016,
    'BMW',
    '3 SERIES',
    '320I XDRIVE SEDAN 4D',
    'MINERAL WHITE METALLIC',
    54813,
    '2025-07-07',
    'SOLD',
    'SOLD',
    '2025-07-07',
    12295.00,
    'Imported from All Inventory.xlsx row 239'
) on conflict (vin) do nothing;

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2025-07-07',
    'ACQUISITION',
    'PURCHASE',
    10860.00,
    'Imported initial purchase cost from legacy inventory summary',
    'LEGACY_IMPORT',
    'WBA8A3C56GK689580'
from public.vehicles v
where v.vin = 'WBA8A3C56GK689580'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'ACQUISITION'
        and l.category = 'PURCHASE'
  );

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2025-07-07',
    'DIRECT_COST',
    'OTHER_DIRECT_COST',
    3902.96,
    'Imported historical direct costs from legacy inventory summary',
    'LEGACY_IMPORT',
    'WBA8A3C56GK689580:other_direct_cost'
from public.vehicles v
where v.vin = 'WBA8A3C56GK689580'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'DIRECT_COST'
        and l.category = 'OTHER_DIRECT_COST'
        and l.source_record_id = 'WBA8A3C56GK689580:other_direct_cost'
  );

insert into public.vehicles (
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
    acquisition_notes
) values (
    'NV124333',
    '1G1YB2D7XH5124333',
    2017,
    'CHEVROLET',
    'CORVETTE',
    'STINGRAY COUPE 2D',
    'RED',
    61426,
    '2024-12-27',
    'IN INVENTORY',
    'IN_INVENTORY',
    null,
    null,
    'Imported from All Inventory.xlsx row 240'
) on conflict (vin) do nothing;

insert into public.vehicles (
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
    acquisition_notes
) values (
    'KA073567',
    'WAUENCF50KA073567',
    2019,
    'AUDI',
    'A5',
    'PREMIUM PLUS SEDAN 4D',
    'GRAY',
    40389,
    '2024-04-12',
    'SOLD',
    'SOLD',
    '2024-04-12',
    24200.00,
    'Imported from All Inventory.xlsx row 243'
) on conflict (vin) do nothing;

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2024-04-12',
    'ACQUISITION',
    'PURCHASE',
    22800.00,
    'Imported initial purchase cost from legacy inventory summary',
    'LEGACY_IMPORT',
    'WAUENCF50KA073567'
from public.vehicles v
where v.vin = 'WAUENCF50KA073567'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'ACQUISITION'
        and l.category = 'PURCHASE'
  );

insert into public.vehicles (
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
    acquisition_notes
) values (
    'NC596272',
    '5N1DR2MM0KC596272',
    2019,
    'NISSAN',
    'PATHFINDER',
    'SL SPORT UTILITY 4D',
    'GUN METALLIC',
    106663,
    '2025-10-09',
    'SOLD',
    'SOLD',
    '2025-10-09',
    12340.00,
    'Imported from All Inventory.xlsx row 244'
) on conflict (vin) do nothing;

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2025-10-09',
    'ACQUISITION',
    'PURCHASE',
    12687.42,
    'Imported initial purchase cost from legacy inventory summary',
    'LEGACY_IMPORT',
    '5N1DR2MM0KC596272'
from public.vehicles v
where v.vin = '5N1DR2MM0KC596272'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'ACQUISITION'
        and l.category = 'PURCHASE'
  );

insert into public.vehicles (
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
    acquisition_notes
) values (
    'NV391083',
    'WBY2Z2C54FV391083',
    2015,
    'BMW',
    'I8',
    'COUPE 2D',
    'WHITE',
    40500,
    '2025-04-22',
    'SOLD',
    'SOLD',
    '2025-04-22',
    51000.00,
    'Imported from All Inventory.xlsx row 245'
) on conflict (vin) do nothing;

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2025-04-22',
    'ACQUISITION',
    'PURCHASE',
    47200.00,
    'Imported initial purchase cost from legacy inventory summary',
    'LEGACY_IMPORT',
    'WBY2Z2C54FV391083'
from public.vehicles v
where v.vin = 'WBY2Z2C54FV391083'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'ACQUISITION'
        and l.category = 'PURCHASE'
  );

insert into public.vehicles (
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
    acquisition_notes
) values (
    'NV102317',
    'JTJBM7FX7F5102317',
    2015,
    'LEXUS',
    'GX',
    'GX 460 SPORT UTILITY 4D',
    'BLACK',
    122388,
    '2024-08-22',
    'SOLD',
    'SOLD',
    '2024-08-22',
    19675.00,
    'Imported from All Inventory.xlsx row 246'
) on conflict (vin) do nothing;

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2024-08-22',
    'ACQUISITION',
    'PURCHASE',
    17500.00,
    'Imported initial purchase cost from legacy inventory summary',
    'LEGACY_IMPORT',
    'JTJBM7FX7F5102317'
from public.vehicles v
where v.vin = 'JTJBM7FX7F5102317'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'ACQUISITION'
        and l.category = 'PURCHASE'
  );

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2024-08-22',
    'DIRECT_COST',
    'OTHER_DIRECT_COST',
    20.00,
    'Imported historical direct costs from legacy inventory summary',
    'LEGACY_IMPORT',
    'JTJBM7FX7F5102317:other_direct_cost'
from public.vehicles v
where v.vin = 'JTJBM7FX7F5102317'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'DIRECT_COST'
        and l.category = 'OTHER_DIRECT_COST'
        and l.source_record_id = 'JTJBM7FX7F5102317:other_direct_cost'
  );

insert into public.vehicles (
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
    acquisition_notes
) values (
    'FH708045',
    '2HGFB6E58FH708045',
    2015,
    'HONDA',
    'CIVIC',
    'SI SEDAN 4D',
    'WHITE',
    114308,
    '2023-08-22',
    'SOLD',
    'SOLD',
    '2023-08-22',
    12800.00,
    'Imported from All Inventory.xlsx row 247'
) on conflict (vin) do nothing;

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2023-08-22',
    'ACQUISITION',
    'PURCHASE',
    11000.00,
    'Imported initial purchase cost from legacy inventory summary',
    'LEGACY_IMPORT',
    '2HGFB6E58FH708045'
from public.vehicles v
where v.vin = '2HGFB6E58FH708045'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'ACQUISITION'
        and l.category = 'PURCHASE'
  );

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2023-08-22',
    'DIRECT_COST',
    'OTHER_DIRECT_COST',
    599.55,
    'Imported historical direct costs from legacy inventory summary',
    'LEGACY_IMPORT',
    '2HGFB6E58FH708045:other_direct_cost'
from public.vehicles v
where v.vin = '2HGFB6E58FH708045'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'DIRECT_COST'
        and l.category = 'OTHER_DIRECT_COST'
        and l.source_record_id = '2HGFB6E58FH708045:other_direct_cost'
  );

insert into public.vehicles (
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
    acquisition_notes
) values (
    'NVU26185',
    '5UXXW7C3XH0U26185',
    2017,
    'BMW',
    'X4',
    'M40I SPORT UTILITY 4D',
    'BLACK',
    78651,
    '2024-11-22',
    'SOLD',
    'SOLD',
    '2024-11-22',
    18495.00,
    'Imported from All Inventory.xlsx row 248'
) on conflict (vin) do nothing;

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2024-11-22',
    'ACQUISITION',
    'PURCHASE',
    14900.00,
    'Imported initial purchase cost from legacy inventory summary',
    'LEGACY_IMPORT',
    '5UXXW7C3XH0U26185'
from public.vehicles v
where v.vin = '5UXXW7C3XH0U26185'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'ACQUISITION'
        and l.category = 'PURCHASE'
  );

insert into public.vehicle_cost_ledger (
    vehicle_id,
    entry_date,
    entry_type,
    category,
    amount,
    description,
    source_system,
    source_record_id
)
select
    v.vehicle_id,
    '2024-11-22',
    'DIRECT_COST',
    'OTHER_DIRECT_COST',
    279.50,
    'Imported historical direct costs from legacy inventory summary',
    'LEGACY_IMPORT',
    '5UXXW7C3XH0U26185:other_direct_cost'
from public.vehicles v
where v.vin = '5UXXW7C3XH0U26185'
  and not exists (
      select 1
      from public.vehicle_cost_ledger l
      where l.vehicle_id = v.vehicle_id
        and l.entry_type = 'DIRECT_COST'
        and l.category = 'OTHER_DIRECT_COST'
        and l.source_record_id = '5UXXW7C3XH0U26185:other_direct_cost'
  );

commit;
