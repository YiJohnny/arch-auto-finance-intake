-- Rental fleet vehicle import generated from rental_vehicles.xlsx
-- Run supabase_intake_unmatched_vehicle_v1.sql and supabase_view_vehicle_master_sheet.sql first so fund_allocation exists and appears in the master sheet view.
-- This imports vehicle master records only. It does not create accounting ledger costs.
-- purchase_date is set to current_date as a temporary required value because the source file has no purchase/in-service date.

begin;

insert into public.vehicles (
    stock_number,
    vin,
    year,
    make,
    model,
    purchase_date,
    purchase_source,
    status,
    business_use,
    fund_allocation,
    acquisition_notes
) values (
    'DA10348',
    'WP1AA2AY6KDA10348',
    2019,
    'Porsche',
    'Cayenne',
    current_date,
    'Rental Fleet',
    'IN_INVENTORY',
    'rental',
    'F1',
    'Rental fleet import from rental_vehicles.xlsx; unit=DA10348_2019 Porsche Cayenne Sport Utility 4D; purchase_date placeholder=current_date'
)
on conflict (vin) do update set
    stock_number = excluded.stock_number,
    year = excluded.year,
    make = excluded.make,
    model = excluded.model,
    purchase_source = coalesce(public.vehicles.purchase_source, 'Rental Fleet'),
    business_use = 'rental',
    fund_allocation = excluded.fund_allocation,
    acquisition_notes = coalesce(public.vehicles.acquisition_notes, excluded.acquisition_notes);

insert into public.vehicles (
    stock_number,
    vin,
    year,
    make,
    model,
    purchase_date,
    purchase_source,
    status,
    business_use,
    fund_allocation,
    acquisition_notes
) values (
    'LJ000406',
    'JTDFPRAE0LJ000406',
    2020,
    'Toyota',
    'Corolla',
    current_date,
    'Rental Fleet',
    'IN_INVENTORY',
    'rental',
    'F1',
    'Rental fleet import from rental_vehicles.xlsx; unit=LJ000406_2020 Toyota Corolla XLE; purchase_date placeholder=current_date'
)
on conflict (vin) do update set
    stock_number = excluded.stock_number,
    year = excluded.year,
    make = excluded.make,
    model = excluded.model,
    purchase_source = coalesce(public.vehicles.purchase_source, 'Rental Fleet'),
    business_use = 'rental',
    fund_allocation = excluded.fund_allocation,
    acquisition_notes = coalesce(public.vehicles.acquisition_notes, excluded.acquisition_notes);

insert into public.vehicles (
    stock_number,
    vin,
    year,
    make,
    model,
    purchase_date,
    purchase_source,
    status,
    business_use,
    fund_allocation,
    acquisition_notes
) values (
    'JA085646',
    'WAUC4CF50JA085646',
    2018,
    'Audi',
    'S5',
    current_date,
    'Rental Fleet',
    'IN_INVENTORY',
    'rental',
    'F1',
    'Rental fleet import from rental_vehicles.xlsx; unit=JA085646_2018 Audi S5 Prestige Sedan 4D WHI; purchase_date placeholder=current_date'
)
on conflict (vin) do update set
    stock_number = excluded.stock_number,
    year = excluded.year,
    make = excluded.make,
    model = excluded.model,
    purchase_source = coalesce(public.vehicles.purchase_source, 'Rental Fleet'),
    business_use = 'rental',
    fund_allocation = excluded.fund_allocation,
    acquisition_notes = coalesce(public.vehicles.acquisition_notes, excluded.acquisition_notes);

insert into public.vehicles (
    stock_number,
    vin,
    year,
    make,
    model,
    purchase_date,
    purchase_source,
    status,
    business_use,
    fund_allocation,
    acquisition_notes
) values (
    'GN008350',
    'WAUWGAFC0GN008350',
    2016,
    'Audi',
    'A7',
    current_date,
    'Rental Fleet',
    'IN_INVENTORY',
    'rental',
    'F1',
    'Rental fleet import from rental_vehicles.xlsx; unit=GN008350_2016 AUDI A7 3.0T PREMIUM PLUS; purchase_date placeholder=current_date'
)
on conflict (vin) do update set
    stock_number = excluded.stock_number,
    year = excluded.year,
    make = excluded.make,
    model = excluded.model,
    purchase_source = coalesce(public.vehicles.purchase_source, 'Rental Fleet'),
    business_use = 'rental',
    fund_allocation = excluded.fund_allocation,
    acquisition_notes = coalesce(public.vehicles.acquisition_notes, excluded.acquisition_notes);

insert into public.vehicles (
    stock_number,
    vin,
    year,
    make,
    model,
    purchase_date,
    purchase_source,
    status,
    business_use,
    fund_allocation,
    acquisition_notes
) values (
    'KA022488',
    'WAUDNAF43KA022488',
    2019,
    'Audi',
    'A4',
    current_date,
    'Rental Fleet',
    'IN_INVENTORY',
    'rental',
    'F1',
    'Rental fleet import from rental_vehicles.xlsx; unit=KA022488_2019 AUDI A4 2.0T QUATTRO PREMIUM; purchase_date placeholder=current_date'
)
on conflict (vin) do update set
    stock_number = excluded.stock_number,
    year = excluded.year,
    make = excluded.make,
    model = excluded.model,
    purchase_source = coalesce(public.vehicles.purchase_source, 'Rental Fleet'),
    business_use = 'rental',
    fund_allocation = excluded.fund_allocation,
    acquisition_notes = coalesce(public.vehicles.acquisition_notes, excluded.acquisition_notes);

insert into public.vehicles (
    stock_number,
    vin,
    year,
    make,
    model,
    purchase_date,
    purchase_source,
    status,
    business_use,
    fund_allocation,
    acquisition_notes
) values (
    'HLB03750',
    'WP1AA2A58HLB03750',
    2017,
    'Porsche',
    'Macan',
    current_date,
    'Rental Fleet',
    'IN_INVENTORY',
    'rental',
    'F1',
    'Rental fleet import from rental_vehicles.xlsx; unit=HLB03750_2017 PORSCHE MACAN; purchase_date placeholder=current_date'
)
on conflict (vin) do update set
    stock_number = excluded.stock_number,
    year = excluded.year,
    make = excluded.make,
    model = excluded.model,
    purchase_source = coalesce(public.vehicles.purchase_source, 'Rental Fleet'),
    business_use = 'rental',
    fund_allocation = excluded.fund_allocation,
    acquisition_notes = coalesce(public.vehicles.acquisition_notes, excluded.acquisition_notes);

insert into public.vehicles (
    stock_number,
    vin,
    year,
    make,
    model,
    purchase_date,
    purchase_source,
    status,
    business_use,
    fund_allocation,
    acquisition_notes
) values (
    'HH219602',
    '2HKRW6H36HH219602',
    2017,
    'Honda',
    'CR-V',
    current_date,
    'Rental Fleet',
    'IN_INVENTORY',
    'rental',
    'F1',
    'Rental fleet import from rental_vehicles.xlsx; unit=HH219602_2017 HONDA CR-V LX; purchase_date placeholder=current_date'
)
on conflict (vin) do update set
    stock_number = excluded.stock_number,
    year = excluded.year,
    make = excluded.make,
    model = excluded.model,
    purchase_source = coalesce(public.vehicles.purchase_source, 'Rental Fleet'),
    business_use = 'rental',
    fund_allocation = excluded.fund_allocation,
    acquisition_notes = coalesce(public.vehicles.acquisition_notes, excluded.acquisition_notes);

insert into public.vehicles (
    stock_number,
    vin,
    year,
    make,
    model,
    purchase_date,
    purchase_source,
    status,
    business_use,
    fund_allocation,
    acquisition_notes
) values (
    'ENS71580',
    'WBA3C3G56ENS71580',
    2014,
    'BMW',
    '3 Series',
    current_date,
    'Rental Fleet',
    'IN_INVENTORY',
    'rental',
    'F1',
    'Rental fleet import from rental_vehicles.xlsx; unit=ENS71580_2014 BMW 3 SERIES 320I XDRIVE; purchase_date placeholder=current_date'
)
on conflict (vin) do update set
    stock_number = excluded.stock_number,
    year = excluded.year,
    make = excluded.make,
    model = excluded.model,
    purchase_source = coalesce(public.vehicles.purchase_source, 'Rental Fleet'),
    business_use = 'rental',
    fund_allocation = excluded.fund_allocation,
    acquisition_notes = coalesce(public.vehicles.acquisition_notes, excluded.acquisition_notes);

insert into public.vehicles (
    stock_number,
    vin,
    year,
    make,
    model,
    purchase_date,
    purchase_source,
    status,
    business_use,
    fund_allocation,
    acquisition_notes
) values (
    'HC941579',
    '1C4RJFLG3HC941579',
    2017,
    'Jeep',
    'Grand Cherokee',
    current_date,
    'Rental Fleet',
    'IN_INVENTORY',
    'rental',
    'F1',
    'Rental fleet import from rental_vehicles.xlsx; unit=HC941579_2017 JEEP GRAND CHEROKEE TRAILHAWK; purchase_date placeholder=current_date'
)
on conflict (vin) do update set
    stock_number = excluded.stock_number,
    year = excluded.year,
    make = excluded.make,
    model = excluded.model,
    purchase_source = coalesce(public.vehicles.purchase_source, 'Rental Fleet'),
    business_use = 'rental',
    fund_allocation = excluded.fund_allocation,
    acquisition_notes = coalesce(public.vehicles.acquisition_notes, excluded.acquisition_notes);

insert into public.vehicles (
    stock_number,
    vin,
    year,
    make,
    model,
    purchase_date,
    purchase_source,
    status,
    business_use,
    fund_allocation,
    acquisition_notes
) values (
    'M9269377',
    'JN8AZ2AE0M9269377',
    2021,
    'Infiniti',
    'QX80',
    current_date,
    'Rental Fleet',
    'IN_INVENTORY',
    'rental',
    'F1',
    'Rental fleet import from rental_vehicles.xlsx; unit=M9269377_2021 INFINITI QX80 LUXE; purchase_date placeholder=current_date'
)
on conflict (vin) do update set
    stock_number = excluded.stock_number,
    year = excluded.year,
    make = excluded.make,
    model = excluded.model,
    purchase_source = coalesce(public.vehicles.purchase_source, 'Rental Fleet'),
    business_use = 'rental',
    fund_allocation = excluded.fund_allocation,
    acquisition_notes = coalesce(public.vehicles.acquisition_notes, excluded.acquisition_notes);

insert into public.vehicles (
    stock_number,
    vin,
    year,
    make,
    model,
    purchase_date,
    purchase_source,
    status,
    business_use,
    fund_allocation,
    acquisition_notes
) values (
    'RW196870',
    '2T3MWRFVXRW196870',
    2024,
    'Toyota',
    'Rav4',
    current_date,
    'Rental Fleet',
    'IN_INVENTORY',
    'rental',
    'F2',
    'Rental fleet import from rental_vehicles.xlsx; unit=RW196870_2024 TOYOTA RAV4 HYBRID LE; purchase_date placeholder=current_date'
)
on conflict (vin) do update set
    stock_number = excluded.stock_number,
    year = excluded.year,
    make = excluded.make,
    model = excluded.model,
    purchase_source = coalesce(public.vehicles.purchase_source, 'Rental Fleet'),
    business_use = 'rental',
    fund_allocation = excluded.fund_allocation,
    acquisition_notes = coalesce(public.vehicles.acquisition_notes, excluded.acquisition_notes);

insert into public.vehicles (
    stock_number,
    vin,
    year,
    make,
    model,
    purchase_date,
    purchase_source,
    status,
    business_use,
    fund_allocation,
    acquisition_notes
) values (
    'FX240218',
    'WDCYC3HFXFX240218',
    2015,
    'Mercedes-Benz',
    'G-Class',
    current_date,
    'Rental Fleet',
    'IN_INVENTORY',
    'rental',
    'F2',
    'Rental fleet import from rental_vehicles.xlsx; unit=FX240218_2015 MERCEDES-BENZ G-CLASS G 550; purchase_date placeholder=current_date'
)
on conflict (vin) do update set
    stock_number = excluded.stock_number,
    year = excluded.year,
    make = excluded.make,
    model = excluded.model,
    purchase_source = coalesce(public.vehicles.purchase_source, 'Rental Fleet'),
    business_use = 'rental',
    fund_allocation = excluded.fund_allocation,
    acquisition_notes = coalesce(public.vehicles.acquisition_notes, excluded.acquisition_notes);

insert into public.vehicles (
    stock_number,
    vin,
    year,
    make,
    model,
    purchase_date,
    purchase_source,
    status,
    business_use,
    fund_allocation,
    acquisition_notes
) values (
    'LA033525',
    '4JGFB4KB6LA033525',
    2020,
    'Mercedes-Benz',
    'GLE',
    current_date,
    'Rental Fleet',
    'IN_INVENTORY',
    'rental',
    'F2',
    'Rental fleet import from rental_vehicles.xlsx; unit=LA033525_2020 MERCEDES-BENZ GLE 350 4MATIC; purchase_date placeholder=current_date'
)
on conflict (vin) do update set
    stock_number = excluded.stock_number,
    year = excluded.year,
    make = excluded.make,
    model = excluded.model,
    purchase_source = coalesce(public.vehicles.purchase_source, 'Rental Fleet'),
    business_use = 'rental',
    fund_allocation = excluded.fund_allocation,
    acquisition_notes = coalesce(public.vehicles.acquisition_notes, excluded.acquisition_notes);

insert into public.vehicles (
    stock_number,
    vin,
    year,
    make,
    model,
    purchase_date,
    purchase_source,
    status,
    business_use,
    fund_allocation,
    acquisition_notes
) values (
    'CH301767',
    '2HGFB2F51CH301767',
    2012,
    'Honda',
    'Civic',
    current_date,
    'Rental Fleet',
    'IN_INVENTORY',
    'rental',
    'F2',
    'Rental fleet import from rental_vehicles.xlsx; unit=CH301767_2012 Honda Civic LX Sedan 4D; purchase_date placeholder=current_date'
)
on conflict (vin) do update set
    stock_number = excluded.stock_number,
    year = excluded.year,
    make = excluded.make,
    model = excluded.model,
    purchase_source = coalesce(public.vehicles.purchase_source, 'Rental Fleet'),
    business_use = 'rental',
    fund_allocation = excluded.fund_allocation,
    acquisition_notes = coalesce(public.vehicles.acquisition_notes, excluded.acquisition_notes);

insert into public.vehicles (
    stock_number,
    vin,
    year,
    make,
    model,
    purchase_date,
    purchase_source,
    status,
    business_use,
    fund_allocation,
    acquisition_notes
) values (
    'FC575756',
    '1N4AL3AP4FC575756',
    2015,
    'Nissan',
    'Altima',
    current_date,
    'Rental Fleet',
    'IN_INVENTORY',
    'rental',
    'F2',
    'Rental fleet import from rental_vehicles.xlsx; unit=FC575756_2015 Nissan Altima 2.5 S Sedan 4D; purchase_date placeholder=current_date'
)
on conflict (vin) do update set
    stock_number = excluded.stock_number,
    year = excluded.year,
    make = excluded.make,
    model = excluded.model,
    purchase_source = coalesce(public.vehicles.purchase_source, 'Rental Fleet'),
    business_use = 'rental',
    fund_allocation = excluded.fund_allocation,
    acquisition_notes = coalesce(public.vehicles.acquisition_notes, excluded.acquisition_notes);

insert into public.vehicles (
    stock_number,
    vin,
    year,
    make,
    model,
    purchase_date,
    purchase_source,
    status,
    business_use,
    fund_allocation,
    acquisition_notes
) values (
    '7A000361',
    '1HGCM56307A000361',
    2007,
    'Honda',
    'Accord',
    current_date,
    'Rental Fleet',
    'IN_INVENTORY',
    'rental',
    'F2',
    'Rental fleet import from rental_vehicles.xlsx; unit=2007 Honda Accord; purchase_date placeholder=current_date'
)
on conflict (vin) do update set
    stock_number = excluded.stock_number,
    year = excluded.year,
    make = excluded.make,
    model = excluded.model,
    purchase_source = coalesce(public.vehicles.purchase_source, 'Rental Fleet'),
    business_use = 'rental',
    fund_allocation = excluded.fund_allocation,
    acquisition_notes = coalesce(public.vehicles.acquisition_notes, excluded.acquisition_notes);

insert into public.vehicles (
    stock_number,
    vin,
    year,
    make,
    model,
    purchase_date,
    purchase_source,
    status,
    business_use,
    fund_allocation,
    acquisition_notes
) values (
    'L5110394',
    '1G1Y82D48L5110394',
    2020,
    'Chevrolet',
    'Corvette',
    current_date,
    'Rental Fleet',
    'IN_INVENTORY',
    'rental',
    'F2',
    'Rental fleet import from rental_vehicles.xlsx; unit=2020 Chevrolet Corvette Stingray Coupe 2D; purchase_date placeholder=current_date'
)
on conflict (vin) do update set
    stock_number = excluded.stock_number,
    year = excluded.year,
    make = excluded.make,
    model = excluded.model,
    purchase_source = coalesce(public.vehicles.purchase_source, 'Rental Fleet'),
    business_use = 'rental',
    fund_allocation = excluded.fund_allocation,
    acquisition_notes = coalesce(public.vehicles.acquisition_notes, excluded.acquisition_notes);

insert into public.vehicles (
    stock_number,
    vin,
    year,
    make,
    model,
    purchase_date,
    purchase_source,
    status,
    business_use,
    fund_allocation,
    acquisition_notes
) values (
    'KC640043',
    '1C4RJFCG3KC640043',
    2019,
    'Jeep',
    'Grand Cherokee',
    current_date,
    'Rental Fleet',
    'IN_INVENTORY',
    'rental',
    'F2',
    'Rental fleet import from rental_vehicles.xlsx; unit=2019 Jeep Grand Cherokee; purchase_date placeholder=current_date'
)
on conflict (vin) do update set
    stock_number = excluded.stock_number,
    year = excluded.year,
    make = excluded.make,
    model = excluded.model,
    purchase_source = coalesce(public.vehicles.purchase_source, 'Rental Fleet'),
    business_use = 'rental',
    fund_allocation = excluded.fund_allocation,
    acquisition_notes = coalesce(public.vehicles.acquisition_notes, excluded.acquisition_notes);

insert into public.vehicles (
    stock_number,
    vin,
    year,
    make,
    model,
    purchase_date,
    purchase_source,
    status,
    business_use,
    fund_allocation,
    acquisition_notes
) values (
    'P0138961',
    '1G1FB1RS7P0138961',
    2023,
    'Chevrolet',
    'Camaro',
    current_date,
    'Rental Fleet',
    'IN_INVENTORY',
    'rental',
    'F3',
    'Rental fleet import from rental_vehicles.xlsx; unit=P0138961_2023 CHEVROLET CAMARO LT; purchase_date placeholder=current_date'
)
on conflict (vin) do update set
    stock_number = excluded.stock_number,
    year = excluded.year,
    make = excluded.make,
    model = excluded.model,
    purchase_source = coalesce(public.vehicles.purchase_source, 'Rental Fleet'),
    business_use = 'rental',
    fund_allocation = excluded.fund_allocation,
    acquisition_notes = coalesce(public.vehicles.acquisition_notes, excluded.acquisition_notes);

insert into public.vehicles (
    stock_number,
    vin,
    year,
    make,
    model,
    purchase_date,
    purchase_source,
    status,
    business_use,
    fund_allocation,
    acquisition_notes
) values (
    'HW603007',
    '2T3DFREV3HW603007',
    2017,
    'Toyota',
    'Rav4',
    current_date,
    'Rental Fleet',
    'IN_INVENTORY',
    'rental',
    'F3',
    'Rental fleet import from rental_vehicles.xlsx; unit=HW603007_2017 Toyota RAV4 Limited Sport Utility 4D; purchase_date placeholder=current_date'
)
on conflict (vin) do update set
    stock_number = excluded.stock_number,
    year = excluded.year,
    make = excluded.make,
    model = excluded.model,
    purchase_source = coalesce(public.vehicles.purchase_source, 'Rental Fleet'),
    business_use = 'rental',
    fund_allocation = excluded.fund_allocation,
    acquisition_notes = coalesce(public.vehicles.acquisition_notes, excluded.acquisition_notes);

insert into public.vehicles (
    stock_number,
    vin,
    year,
    make,
    model,
    purchase_date,
    purchase_source,
    status,
    business_use,
    fund_allocation,
    acquisition_notes
) values (
    'KA541619',
    'SALGS2RE7KA541619',
    2019,
    'Land Rover',
    'Range Rover',
    current_date,
    'Rental Fleet',
    'IN_INVENTORY',
    'rental',
    'F3',
    'Rental fleet import from rental_vehicles.xlsx; unit=KA541619_2019 LAND ROVER SUPERCHARGED; purchase_date placeholder=current_date'
)
on conflict (vin) do update set
    stock_number = excluded.stock_number,
    year = excluded.year,
    make = excluded.make,
    model = excluded.model,
    purchase_source = coalesce(public.vehicles.purchase_source, 'Rental Fleet'),
    business_use = 'rental',
    fund_allocation = excluded.fund_allocation,
    acquisition_notes = coalesce(public.vehicles.acquisition_notes, excluded.acquisition_notes);

insert into public.vehicles (
    stock_number,
    vin,
    year,
    make,
    model,
    purchase_date,
    purchase_source,
    status,
    business_use,
    fund_allocation,
    acquisition_notes
) values (
    'RU073117',
    '4T1K31AK0RU073117',
    2024,
    'Toyota',
    'Camry',
    current_date,
    'Rental Fleet',
    'IN_INVENTORY',
    'rental',
    'F3',
    'Rental fleet import from rental_vehicles.xlsx; unit=RU073117_2024 TOYOTA CAMRY HYBRID XSE; purchase_date placeholder=current_date'
)
on conflict (vin) do update set
    stock_number = excluded.stock_number,
    year = excluded.year,
    make = excluded.make,
    model = excluded.model,
    purchase_source = coalesce(public.vehicles.purchase_source, 'Rental Fleet'),
    business_use = 'rental',
    fund_allocation = excluded.fund_allocation,
    acquisition_notes = coalesce(public.vehicles.acquisition_notes, excluded.acquisition_notes);

insert into public.vehicles (
    stock_number,
    vin,
    year,
    make,
    model,
    purchase_date,
    purchase_source,
    status,
    business_use,
    fund_allocation,
    acquisition_notes
) values (
    'JF020157',
    '5YJ3E1EA9JF020157',
    2018,
    'Tesla',
    'Model 3',
    current_date,
    'Rental Fleet',
    'IN_INVENTORY',
    'rental',
    'F3',
    'Rental fleet import from rental_vehicles.xlsx; unit=JF020157_2018 TESLA MODEL 3 LONG RANGE; purchase_date placeholder=current_date'
)
on conflict (vin) do update set
    stock_number = excluded.stock_number,
    year = excluded.year,
    make = excluded.make,
    model = excluded.model,
    purchase_source = coalesce(public.vehicles.purchase_source, 'Rental Fleet'),
    business_use = 'rental',
    fund_allocation = excluded.fund_allocation,
    acquisition_notes = coalesce(public.vehicles.acquisition_notes, excluded.acquisition_notes);

insert into public.vehicles (
    stock_number,
    vin,
    year,
    make,
    model,
    purchase_date,
    purchase_source,
    status,
    business_use,
    fund_allocation,
    acquisition_notes
) values (
    'FC299450',
    '2T1BURHEXFC299450',
    2015,
    'Toyota',
    'Corolla',
    current_date,
    'Rental Fleet',
    'IN_INVENTORY',
    'rental',
    'F3',
    'Rental fleet import from rental_vehicles.xlsx; unit=FC299450_2015 TOYOTA COROLLA S PLUS; purchase_date placeholder=current_date'
)
on conflict (vin) do update set
    stock_number = excluded.stock_number,
    year = excluded.year,
    make = excluded.make,
    model = excluded.model,
    purchase_source = coalesce(public.vehicles.purchase_source, 'Rental Fleet'),
    business_use = 'rental',
    fund_allocation = excluded.fund_allocation,
    acquisition_notes = coalesce(public.vehicles.acquisition_notes, excluded.acquisition_notes);

insert into public.vehicles (
    stock_number,
    vin,
    year,
    make,
    model,
    purchase_date,
    purchase_source,
    status,
    business_use,
    fund_allocation,
    acquisition_notes
) values (
    'M8B70410',
    '3MW5R7J06M8B70410',
    2021,
    'BMW',
    '3 Series',
    current_date,
    'Rental Fleet',
    'IN_INVENTORY',
    'rental',
    'F3',
    'Rental fleet import from rental_vehicles.xlsx; unit=M8B70410_2021 BMW 3 SERIES 330I XDRIVE; purchase_date placeholder=current_date'
)
on conflict (vin) do update set
    stock_number = excluded.stock_number,
    year = excluded.year,
    make = excluded.make,
    model = excluded.model,
    purchase_source = coalesce(public.vehicles.purchase_source, 'Rental Fleet'),
    business_use = 'rental',
    fund_allocation = excluded.fund_allocation,
    acquisition_notes = coalesce(public.vehicles.acquisition_notes, excluded.acquisition_notes);

insert into public.vehicles (
    stock_number,
    vin,
    year,
    make,
    model,
    purchase_date,
    purchase_source,
    status,
    business_use,
    fund_allocation,
    acquisition_notes
) values (
    'S9Y26324',
    '5UX23EM06S9Y26324',
    2025,
    'BMW',
    'X7',
    current_date,
    'Rental Fleet',
    'IN_INVENTORY',
    'rental',
    'F3',
    'Rental fleet import from rental_vehicles.xlsx; unit=S9Y26324_2025 BMW X7 XDRIVE40I SPORT UTILITY 4D; purchase_date placeholder=current_date'
)
on conflict (vin) do update set
    stock_number = excluded.stock_number,
    year = excluded.year,
    make = excluded.make,
    model = excluded.model,
    purchase_source = coalesce(public.vehicles.purchase_source, 'Rental Fleet'),
    business_use = 'rental',
    fund_allocation = excluded.fund_allocation,
    acquisition_notes = coalesce(public.vehicles.acquisition_notes, excluded.acquisition_notes);

insert into public.vehicles (
    stock_number,
    vin,
    year,
    make,
    model,
    purchase_date,
    purchase_source,
    status,
    business_use,
    fund_allocation,
    acquisition_notes
) values (
    'JF672249',
    'WDDWJ4KB7JF672249',
    2019,
    'Mercedes-Benz',
    'C300',
    current_date,
    'Rental Fleet',
    'IN_INVENTORY',
    'rental',
    'F3',
    'Rental fleet import from rental_vehicles.xlsx; unit=2019 MERCEDES-BENZ C300 COUPE; purchase_date placeholder=current_date'
)
on conflict (vin) do update set
    stock_number = excluded.stock_number,
    year = excluded.year,
    make = excluded.make,
    model = excluded.model,
    purchase_source = coalesce(public.vehicles.purchase_source, 'Rental Fleet'),
    business_use = 'rental',
    fund_allocation = excluded.fund_allocation,
    acquisition_notes = coalesce(public.vehicles.acquisition_notes, excluded.acquisition_notes);

insert into public.vehicles (
    stock_number,
    vin,
    year,
    make,
    model,
    purchase_date,
    purchase_source,
    status,
    business_use,
    fund_allocation,
    acquisition_notes
) values (
    'KD022718',
    'WA1LHAF74KD022718',
    2019,
    'Audi',
    'Q7',
    current_date,
    'Rental Fleet',
    'IN_INVENTORY',
    'rental',
    'F3',
    'Rental fleet import from rental_vehicles.xlsx; unit=2019 AUDI Q7 WAGON; purchase_date placeholder=current_date'
)
on conflict (vin) do update set
    stock_number = excluded.stock_number,
    year = excluded.year,
    make = excluded.make,
    model = excluded.model,
    purchase_source = coalesce(public.vehicles.purchase_source, 'Rental Fleet'),
    business_use = 'rental',
    fund_allocation = excluded.fund_allocation,
    acquisition_notes = coalesce(public.vehicles.acquisition_notes, excluded.acquisition_notes);

insert into public.vehicles (
    stock_number,
    vin,
    year,
    make,
    model,
    purchase_date,
    purchase_source,
    status,
    business_use,
    fund_allocation,
    acquisition_notes
) values (
    'MF161337',
    '5YJYGDEE2MF161337',
    2021,
    'Tesla',
    'Model Y',
    current_date,
    'Rental Fleet',
    'IN_INVENTORY',
    'rental',
    'F3',
    'Rental fleet import from rental_vehicles.xlsx; unit=2021 TESLA MODEL Y SIL; purchase_date placeholder=current_date'
)
on conflict (vin) do update set
    stock_number = excluded.stock_number,
    year = excluded.year,
    make = excluded.make,
    model = excluded.model,
    purchase_source = coalesce(public.vehicles.purchase_source, 'Rental Fleet'),
    business_use = 'rental',
    fund_allocation = excluded.fund_allocation,
    acquisition_notes = coalesce(public.vehicles.acquisition_notes, excluded.acquisition_notes);

insert into public.vehicles (
    stock_number,
    vin,
    year,
    make,
    model,
    purchase_date,
    purchase_source,
    status,
    business_use,
    fund_allocation,
    acquisition_notes
) values (
    'HC118670',
    '2T2BZMCA9HC118670',
    2017,
    'Lexus',
    'RX',
    current_date,
    'Rental Fleet',
    'IN_INVENTORY',
    'rental',
    'F3',
    'Rental fleet import from rental_vehicles.xlsx; unit=HC118670_2017 LEXUS RX 350; purchase_date placeholder=current_date'
)
on conflict (vin) do update set
    stock_number = excluded.stock_number,
    year = excluded.year,
    make = excluded.make,
    model = excluded.model,
    purchase_source = coalesce(public.vehicles.purchase_source, 'Rental Fleet'),
    business_use = 'rental',
    fund_allocation = excluded.fund_allocation,
    acquisition_notes = coalesce(public.vehicles.acquisition_notes, excluded.acquisition_notes);

insert into public.vehicles (
    stock_number,
    vin,
    year,
    make,
    model,
    purchase_date,
    purchase_source,
    status,
    business_use,
    fund_allocation,
    acquisition_notes
) values (
    'FC675799',
    '5N1AR2MM7FC675799',
    2015,
    'Nissan',
    'Pathfinder',
    current_date,
    'Rental Fleet',
    'IN_INVENTORY',
    'rental',
    'F3',
    'Rental fleet import from rental_vehicles.xlsx; unit=2015 Nissan Pathfinder SL Sport Utility 4D; purchase_date placeholder=current_date'
)
on conflict (vin) do update set
    stock_number = excluded.stock_number,
    year = excluded.year,
    make = excluded.make,
    model = excluded.model,
    purchase_source = coalesce(public.vehicles.purchase_source, 'Rental Fleet'),
    business_use = 'rental',
    fund_allocation = excluded.fund_allocation,
    acquisition_notes = coalesce(public.vehicles.acquisition_notes, excluded.acquisition_notes);

insert into public.vehicles (
    stock_number,
    vin,
    year,
    make,
    model,
    purchase_date,
    purchase_source,
    status,
    business_use,
    fund_allocation,
    acquisition_notes
) values (
    'PF406644',
    '5YJ3E1EAXPF406644',
    2023,
    'Tesla',
    'Model 3',
    current_date,
    'Rental Fleet',
    'IN_INVENTORY',
    'rental',
    'F3',
    'Rental fleet import from rental_vehicles.xlsx; unit=2023 Tesla Model 3; purchase_date placeholder=current_date'
)
on conflict (vin) do update set
    stock_number = excluded.stock_number,
    year = excluded.year,
    make = excluded.make,
    model = excluded.model,
    purchase_source = coalesce(public.vehicles.purchase_source, 'Rental Fleet'),
    business_use = 'rental',
    fund_allocation = excluded.fund_allocation,
    acquisition_notes = coalesce(public.vehicles.acquisition_notes, excluded.acquisition_notes);

insert into public.vehicles (
    stock_number,
    vin,
    year,
    make,
    model,
    purchase_date,
    purchase_source,
    status,
    business_use,
    fund_allocation,
    acquisition_notes
) values (
    'FA135184',
    'WDDLJ7GB3FA135184',
    2015,
    'Mercedes-AMG',
    'AMG',
    current_date,
    'Rental Fleet',
    'IN_INVENTORY',
    'rental',
    'F3',
    'Rental fleet import from rental_vehicles.xlsx; unit=Mercedes-AMG CLS 63S; purchase_date placeholder=current_date'
)
on conflict (vin) do update set
    stock_number = excluded.stock_number,
    year = excluded.year,
    make = excluded.make,
    model = excluded.model,
    purchase_source = coalesce(public.vehicles.purchase_source, 'Rental Fleet'),
    business_use = 'rental',
    fund_allocation = excluded.fund_allocation,
    acquisition_notes = coalesce(public.vehicles.acquisition_notes, excluded.acquisition_notes);

insert into public.vehicles (
    stock_number,
    vin,
    year,
    make,
    model,
    purchase_date,
    purchase_source,
    status,
    business_use,
    fund_allocation,
    acquisition_notes
) values (
    'CKC61752',
    '1FMCU0D75CKC61752',
    2012,
    'Ford',
    'Escap',
    current_date,
    'Rental Fleet',
    'IN_INVENTORY',
    'rental',
    'F3',
    'Rental fleet import from rental_vehicles.xlsx; unit=2012 Ford Escape XLT Sport Utility 4D; purchase_date placeholder=current_date'
)
on conflict (vin) do update set
    stock_number = excluded.stock_number,
    year = excluded.year,
    make = excluded.make,
    model = excluded.model,
    purchase_source = coalesce(public.vehicles.purchase_source, 'Rental Fleet'),
    business_use = 'rental',
    fund_allocation = excluded.fund_allocation,
    acquisition_notes = coalesce(public.vehicles.acquisition_notes, excluded.acquisition_notes);

insert into public.vehicles (
    stock_number,
    vin,
    year,
    make,
    model,
    purchase_date,
    purchase_source,
    status,
    business_use,
    fund_allocation,
    acquisition_notes
) values (
    '72039821',
    'JTJHW31U272039821',
    2007,
    'Lexus',
    'RX',
    current_date,
    'Rental Fleet',
    'IN_INVENTORY',
    'rental',
    'F3',
    'Rental fleet import from rental_vehicles.xlsx; unit=2007 Lexus RX 450h; purchase_date placeholder=current_date'
)
on conflict (vin) do update set
    stock_number = excluded.stock_number,
    year = excluded.year,
    make = excluded.make,
    model = excluded.model,
    purchase_source = coalesce(public.vehicles.purchase_source, 'Rental Fleet'),
    business_use = 'rental',
    fund_allocation = excluded.fund_allocation,
    acquisition_notes = coalesce(public.vehicles.acquisition_notes, excluded.acquisition_notes);

insert into public.vehicles (
    stock_number,
    vin,
    year,
    make,
    model,
    purchase_date,
    purchase_source,
    status,
    business_use,
    fund_allocation,
    acquisition_notes
) values (
    'HGC14738',
    '1FM5K8AR0HGC14738',
    2017,
    'Ford',
    'Explorer',
    current_date,
    'Rental Fleet',
    'IN_INVENTORY',
    'rental',
    'F3',
    'Rental fleet import from rental_vehicles.xlsx; unit=2017 Ford Explorer Utility 4D Police AWD 3.7L V6; purchase_date placeholder=current_date'
)
on conflict (vin) do update set
    stock_number = excluded.stock_number,
    year = excluded.year,
    make = excluded.make,
    model = excluded.model,
    purchase_source = coalesce(public.vehicles.purchase_source, 'Rental Fleet'),
    business_use = 'rental',
    fund_allocation = excluded.fund_allocation,
    acquisition_notes = coalesce(public.vehicles.acquisition_notes, excluded.acquisition_notes);

insert into public.vehicles (
    stock_number,
    vin,
    year,
    make,
    model,
    purchase_date,
    purchase_source,
    status,
    business_use,
    fund_allocation,
    acquisition_notes
) values (
    'KF400793',
    '5YJ3E1EA7KF400793',
    2019,
    'Tesla',
    'Model 3',
    current_date,
    'Rental Fleet',
    'IN_INVENTORY',
    'rental',
    'F4',
    'Rental fleet import from rental_vehicles.xlsx; unit=2018 TESLA MODEL 3 BLUE; purchase_date placeholder=current_date'
)
on conflict (vin) do update set
    stock_number = excluded.stock_number,
    year = excluded.year,
    make = excluded.make,
    model = excluded.model,
    purchase_source = coalesce(public.vehicles.purchase_source, 'Rental Fleet'),
    business_use = 'rental',
    fund_allocation = excluded.fund_allocation,
    acquisition_notes = coalesce(public.vehicles.acquisition_notes, excluded.acquisition_notes);

insert into public.vehicles (
    stock_number,
    vin,
    year,
    make,
    model,
    purchase_date,
    purchase_source,
    status,
    business_use,
    fund_allocation,
    acquisition_notes
) values (
    'KFA54417',
    '1FTFW1RG6KFA54417',
    2019,
    'Ford',
    'F150',
    current_date,
    'Rental Fleet',
    'IN_INVENTORY',
    'rental',
    'F4',
    'Rental fleet import from rental_vehicles.xlsx; unit=2019 Ford F150 SuperCrew Cab Raptor Pickup 4D 5 1/2 ft; purchase_date placeholder=current_date'
)
on conflict (vin) do update set
    stock_number = excluded.stock_number,
    year = excluded.year,
    make = excluded.make,
    model = excluded.model,
    purchase_source = coalesce(public.vehicles.purchase_source, 'Rental Fleet'),
    business_use = 'rental',
    fund_allocation = excluded.fund_allocation,
    acquisition_notes = coalesce(public.vehicles.acquisition_notes, excluded.acquisition_notes);

insert into public.vehicles (
    stock_number,
    vin,
    year,
    make,
    model,
    purchase_date,
    purchase_source,
    status,
    business_use,
    fund_allocation,
    acquisition_notes
) values (
    'KU693623',
    '4T1B61HKXKU693623',
    2019,
    'Toyota',
    'Camry',
    current_date,
    'Rental Fleet',
    'IN_INVENTORY',
    'rental',
    'F3',
    'Rental fleet import from rental_vehicles.xlsx; unit=2019 Toyota Camry XSE; purchase_date placeholder=current_date'
)
on conflict (vin) do update set
    stock_number = excluded.stock_number,
    year = excluded.year,
    make = excluded.make,
    model = excluded.model,
    purchase_source = coalesce(public.vehicles.purchase_source, 'Rental Fleet'),
    business_use = 'rental',
    fund_allocation = excluded.fund_allocation,
    acquisition_notes = coalesce(public.vehicles.acquisition_notes, excluded.acquisition_notes);

insert into public.vehicles (
    stock_number,
    vin,
    year,
    make,
    model,
    purchase_date,
    purchase_source,
    status,
    business_use,
    fund_allocation,
    acquisition_notes
) values (
    'J2450305',
    'YV126MFL1J2450305',
    2018,
    'Volvo',
    'S60',
    current_date,
    'Rental Fleet',
    'IN_INVENTORY',
    'rental',
    'F3',
    'Rental fleet import from rental_vehicles.xlsx; unit=2018 Volvo S60 T5 Dynamic; purchase_date placeholder=current_date'
)
on conflict (vin) do update set
    stock_number = excluded.stock_number,
    year = excluded.year,
    make = excluded.make,
    model = excluded.model,
    purchase_source = coalesce(public.vehicles.purchase_source, 'Rental Fleet'),
    business_use = 'rental',
    fund_allocation = excluded.fund_allocation,
    acquisition_notes = coalesce(public.vehicles.acquisition_notes, excluded.acquisition_notes);

insert into public.vehicles (
    stock_number,
    vin,
    year,
    make,
    model,
    purchase_date,
    purchase_source,
    status,
    business_use,
    fund_allocation,
    acquisition_notes
) values (
    'BS047429',
    '5TDYK3EH2BS047429',
    2011,
    'Toyota',
    'Highlander',
    current_date,
    'Rental Fleet',
    'IN_INVENTORY',
    'rental',
    'F3',
    'Rental fleet import from rental_vehicles.xlsx; unit=2011 Toyota Highlander Limited Sport Utility 4D; purchase_date placeholder=current_date'
)
on conflict (vin) do update set
    stock_number = excluded.stock_number,
    year = excluded.year,
    make = excluded.make,
    model = excluded.model,
    purchase_source = coalesce(public.vehicles.purchase_source, 'Rental Fleet'),
    business_use = 'rental',
    fund_allocation = excluded.fund_allocation,
    acquisition_notes = coalesce(public.vehicles.acquisition_notes, excluded.acquisition_notes);

insert into public.vehicles (
    stock_number,
    vin,
    year,
    make,
    model,
    purchase_date,
    purchase_source,
    status,
    business_use,
    fund_allocation,
    acquisition_notes
) values (
    'LE183693',
    '3KPF24AD3LE183693',
    2020,
    'Kia',
    'Forte',
    current_date,
    'Rental Fleet',
    'IN_INVENTORY',
    'rental',
    'F3',
    'Rental fleet import from rental_vehicles.xlsx; unit=2020 Kia Forte LXS Sedan 4D; purchase_date placeholder=current_date'
)
on conflict (vin) do update set
    stock_number = excluded.stock_number,
    year = excluded.year,
    make = excluded.make,
    model = excluded.model,
    purchase_source = coalesce(public.vehicles.purchase_source, 'Rental Fleet'),
    business_use = 'rental',
    fund_allocation = excluded.fund_allocation,
    acquisition_notes = coalesce(public.vehicles.acquisition_notes, excluded.acquisition_notes);

insert into public.vehicles (
    stock_number,
    vin,
    year,
    make,
    model,
    purchase_date,
    purchase_source,
    status,
    business_use,
    fund_allocation,
    acquisition_notes
) values (
    'GH356513',
    '5NPE24AFXGH356513',
    2016,
    'Hyundai',
    'SONATA SE',
    current_date,
    'Rental Fleet',
    'IN_INVENTORY',
    'rental',
    'F0',
    'Rental fleet import from rental_vehicles.xlsx; unit=GH356513_2016 HYUNDAI SONATA SE; purchase_date placeholder=current_date'
)
on conflict (vin) do update set
    stock_number = excluded.stock_number,
    year = excluded.year,
    make = excluded.make,
    model = excluded.model,
    purchase_source = coalesce(public.vehicles.purchase_source, 'Rental Fleet'),
    business_use = 'rental',
    fund_allocation = excluded.fund_allocation,
    acquisition_notes = coalesce(public.vehicles.acquisition_notes, excluded.acquisition_notes);

insert into public.vehicles (
    stock_number,
    vin,
    year,
    make,
    model,
    purchase_date,
    purchase_source,
    status,
    business_use,
    fund_allocation,
    acquisition_notes
) values (
    'GA035540',
    '4JGED7FB2GA035540',
    2016,
    'Mercedes-Benz',
    'AMG',
    current_date,
    'Rental Fleet',
    'IN_INVENTORY',
    'rental',
    'F0',
    'Rental fleet import from rental_vehicles.xlsx; unit=GA035540_2016 MERCEDES-BENZ GLE 63 AMG S; purchase_date placeholder=current_date'
)
on conflict (vin) do update set
    stock_number = excluded.stock_number,
    year = excluded.year,
    make = excluded.make,
    model = excluded.model,
    purchase_source = coalesce(public.vehicles.purchase_source, 'Rental Fleet'),
    business_use = 'rental',
    fund_allocation = excluded.fund_allocation,
    acquisition_notes = coalesce(public.vehicles.acquisition_notes, excluded.acquisition_notes);

insert into public.vehicles (
    stock_number,
    vin,
    year,
    make,
    model,
    purchase_date,
    purchase_source,
    status,
    business_use,
    fund_allocation,
    acquisition_notes
) values (
    'JX286579',
    'WDCYC3KH4JX286579',
    2018,
    'Mercedes-Benz',
    'G-Class',
    current_date,
    'Rental Fleet',
    'IN_INVENTORY',
    'rental',
    'F2',
    'Rental fleet import from rental_vehicles.xlsx; unit=JX286579_2018 Mercedes-Benz G-Class G550; purchase_date placeholder=current_date'
)
on conflict (vin) do update set
    stock_number = excluded.stock_number,
    year = excluded.year,
    make = excluded.make,
    model = excluded.model,
    purchase_source = coalesce(public.vehicles.purchase_source, 'Rental Fleet'),
    business_use = 'rental',
    fund_allocation = excluded.fund_allocation,
    acquisition_notes = coalesce(public.vehicles.acquisition_notes, excluded.acquisition_notes);

insert into public.vehicles (
    stock_number,
    vin,
    year,
    make,
    model,
    purchase_date,
    purchase_source,
    status,
    business_use,
    fund_allocation,
    acquisition_notes
) values (
    'LJ055637',
    'JTDEPRAE3LJ055637',
    2020,
    'Toyota',
    'Corolla',
    current_date,
    'Rental Fleet',
    'IN_INVENTORY',
    'rental',
    'F0',
    'Rental fleet import from rental_vehicles.xlsx; unit=LJ055637_2020 Toyota Corolla; purchase_date placeholder=current_date'
)
on conflict (vin) do update set
    stock_number = excluded.stock_number,
    year = excluded.year,
    make = excluded.make,
    model = excluded.model,
    purchase_source = coalesce(public.vehicles.purchase_source, 'Rental Fleet'),
    business_use = 'rental',
    fund_allocation = excluded.fund_allocation,
    acquisition_notes = coalesce(public.vehicles.acquisition_notes, excluded.acquisition_notes);

insert into public.vehicles (
    stock_number,
    vin,
    year,
    make,
    model,
    purchase_date,
    purchase_source,
    status,
    business_use,
    fund_allocation,
    acquisition_notes
) values (
    'NF562622',
    '7SAYGDEF5NF562622',
    2022,
    'Tesla',
    'Model Y',
    current_date,
    'Rental Fleet',
    'IN_INVENTORY',
    'rental',
    'AA',
    'Rental fleet import from rental_vehicles.xlsx; unit=NF562622_2022 Tesla Model Y Performance; purchase_date placeholder=current_date'
)
on conflict (vin) do update set
    stock_number = excluded.stock_number,
    year = excluded.year,
    make = excluded.make,
    model = excluded.model,
    purchase_source = coalesce(public.vehicles.purchase_source, 'Rental Fleet'),
    business_use = 'rental',
    fund_allocation = excluded.fund_allocation,
    acquisition_notes = coalesce(public.vehicles.acquisition_notes, excluded.acquisition_notes);

insert into public.vehicles (
    stock_number,
    vin,
    year,
    make,
    model,
    purchase_date,
    purchase_source,
    status,
    business_use,
    fund_allocation,
    acquisition_notes
) values (
    '8B10007',
    '3MW5R7J00L8B10007',
    2020,
    'BMW',
    '3 Series',
    current_date,
    'Rental Fleet',
    'IN_INVENTORY',
    'rental',
    'F1',
    'Rental fleet import from rental_vehicles.xlsx; unit=8B10007_2020 BMW 3 Series 330i xDrive Sedan 4D; purchase_date placeholder=current_date'
)
on conflict (vin) do update set
    stock_number = excluded.stock_number,
    year = excluded.year,
    make = excluded.make,
    model = excluded.model,
    purchase_source = coalesce(public.vehicles.purchase_source, 'Rental Fleet'),
    business_use = 'rental',
    fund_allocation = excluded.fund_allocation,
    acquisition_notes = coalesce(public.vehicles.acquisition_notes, excluded.acquisition_notes);

insert into public.vehicles (
    stock_number,
    vin,
    year,
    make,
    model,
    purchase_date,
    purchase_source,
    status,
    business_use,
    fund_allocation,
    acquisition_notes
) values (
    'G0R72112',
    '5UXKR2C50G0R72112',
    2016,
    'BMW',
    'X5',
    current_date,
    'Rental Fleet',
    'IN_INVENTORY',
    'rental',
    'F2',
    'Rental fleet import from rental_vehicles.xlsx; unit=G0R72112_2015 BMW X5 sDrive; purchase_date placeholder=current_date'
)
on conflict (vin) do update set
    stock_number = excluded.stock_number,
    year = excluded.year,
    make = excluded.make,
    model = excluded.model,
    purchase_source = coalesce(public.vehicles.purchase_source, 'Rental Fleet'),
    business_use = 'rental',
    fund_allocation = excluded.fund_allocation,
    acquisition_notes = coalesce(public.vehicles.acquisition_notes, excluded.acquisition_notes);

insert into public.vehicles (
    stock_number,
    vin,
    year,
    make,
    model,
    purchase_date,
    purchase_source,
    status,
    business_use,
    fund_allocation,
    acquisition_notes
) values (
    'HX271935',
    'WDCYC5FF4HX271935',
    2017,
    'Mercedes-Benz',
    'G-Class',
    current_date,
    'Rental Fleet',
    'IN_INVENTORY',
    'rental',
    'AA',
    'Rental fleet import from rental_vehicles.xlsx; unit=HX271935_2017 Mercedes-Benz G 550 4x4 squared; purchase_date placeholder=current_date'
)
on conflict (vin) do update set
    stock_number = excluded.stock_number,
    year = excluded.year,
    make = excluded.make,
    model = excluded.model,
    purchase_source = coalesce(public.vehicles.purchase_source, 'Rental Fleet'),
    business_use = 'rental',
    fund_allocation = excluded.fund_allocation,
    acquisition_notes = coalesce(public.vehicles.acquisition_notes, excluded.acquisition_notes);

insert into public.vehicles (
    stock_number,
    vin,
    year,
    make,
    model,
    purchase_date,
    purchase_source,
    status,
    business_use,
    fund_allocation,
    acquisition_notes
) values (
    'RA026282',
    '7G2CEHED8RA026282',
    2024,
    'Tesla',
    'Cybertruck',
    current_date,
    'Rental Fleet',
    'IN_INVENTORY',
    'rental',
    'AA',
    'Rental fleet import from rental_vehicles.xlsx; unit=RA026282_2024 TESLA CYBERTRUCK; purchase_date placeholder=current_date'
)
on conflict (vin) do update set
    stock_number = excluded.stock_number,
    year = excluded.year,
    make = excluded.make,
    model = excluded.model,
    purchase_source = coalesce(public.vehicles.purchase_source, 'Rental Fleet'),
    business_use = 'rental',
    fund_allocation = excluded.fund_allocation,
    acquisition_notes = coalesce(public.vehicles.acquisition_notes, excluded.acquisition_notes);

insert into public.vehicles (
    stock_number,
    vin,
    year,
    make,
    model,
    purchase_date,
    purchase_source,
    status,
    business_use,
    fund_allocation,
    acquisition_notes
) values (
    'LC141983',
    '1N4BL4CV2LC141983',
    2020,
    'Nissan',
    'Altima',
    current_date,
    'Rental Fleet',
    'IN_INVENTORY',
    'rental',
    'F2',
    'Rental fleet import from rental_vehicles.xlsx; unit=LC141983_2020 NISSAN ALTIMA SR; purchase_date placeholder=current_date'
)
on conflict (vin) do update set
    stock_number = excluded.stock_number,
    year = excluded.year,
    make = excluded.make,
    model = excluded.model,
    purchase_source = coalesce(public.vehicles.purchase_source, 'Rental Fleet'),
    business_use = 'rental',
    fund_allocation = excluded.fund_allocation,
    acquisition_notes = coalesce(public.vehicles.acquisition_notes, excluded.acquisition_notes);

insert into public.vehicles (
    stock_number,
    vin,
    year,
    make,
    model,
    purchase_date,
    purchase_source,
    status,
    business_use,
    fund_allocation,
    acquisition_notes
) values (
    'RS201097',
    '5TDBRKEC4RS201097',
    2024,
    'Toyota',
    'Sienna',
    current_date,
    'Rental Fleet',
    'IN_INVENTORY',
    'rental',
    'AA',
    'Rental fleet import from rental_vehicles.xlsx; unit=RS201097_2024 TOYOTA SIENNA LE 8-PASSENGER; purchase_date placeholder=current_date'
)
on conflict (vin) do update set
    stock_number = excluded.stock_number,
    year = excluded.year,
    make = excluded.make,
    model = excluded.model,
    purchase_source = coalesce(public.vehicles.purchase_source, 'Rental Fleet'),
    business_use = 'rental',
    fund_allocation = excluded.fund_allocation,
    acquisition_notes = coalesce(public.vehicles.acquisition_notes, excluded.acquisition_notes);

insert into public.vehicles (
    stock_number,
    vin,
    year,
    make,
    model,
    purchase_date,
    purchase_source,
    status,
    business_use,
    fund_allocation,
    acquisition_notes
) values (
    'KF595060',
    'WDC0G6EB5KF595060',
    2019,
    'Mercedes-Benz',
    'AMG',
    current_date,
    'Rental Fleet',
    'IN_INVENTORY',
    'rental',
    'F0',
    'Rental fleet import from rental_vehicles.xlsx; unit=KF595060_2019 MERCEDES-BENZ GLC 43 AMG; purchase_date placeholder=current_date'
)
on conflict (vin) do update set
    stock_number = excluded.stock_number,
    year = excluded.year,
    make = excluded.make,
    model = excluded.model,
    purchase_source = coalesce(public.vehicles.purchase_source, 'Rental Fleet'),
    business_use = 'rental',
    fund_allocation = excluded.fund_allocation,
    acquisition_notes = coalesce(public.vehicles.acquisition_notes, excluded.acquisition_notes);

insert into public.vehicles (
    stock_number,
    vin,
    year,
    make,
    model,
    purchase_date,
    purchase_source,
    status,
    business_use,
    fund_allocation,
    acquisition_notes
) values (
    'F1130152',
    'ZAM57RTA1F1130152',
    2015,
    'Maserati',
    'Ghibli',
    current_date,
    'Rental Fleet',
    'IN_INVENTORY',
    'rental',
    'F0',
    'Rental fleet import from rental_vehicles.xlsx; unit=F1130152_2015 Maserati Ghibli S Q4 Sedan 4D; purchase_date placeholder=current_date'
)
on conflict (vin) do update set
    stock_number = excluded.stock_number,
    year = excluded.year,
    make = excluded.make,
    model = excluded.model,
    purchase_source = coalesce(public.vehicles.purchase_source, 'Rental Fleet'),
    business_use = 'rental',
    fund_allocation = excluded.fund_allocation,
    acquisition_notes = coalesce(public.vehicles.acquisition_notes, excluded.acquisition_notes);

insert into public.vehicles (
    stock_number,
    vin,
    year,
    make,
    model,
    purchase_date,
    purchase_source,
    status,
    business_use,
    fund_allocation,
    acquisition_notes
) values (
    'MN306471',
    '1N4BL4DW5MN306471',
    2021,
    'Nissan',
    'Altima',
    current_date,
    'Rental Fleet',
    'IN_INVENTORY',
    'rental',
    'F0',
    'Rental fleet import from rental_vehicles.xlsx; unit=MN306471_2021 Nissan Altima AWD; purchase_date placeholder=current_date'
)
on conflict (vin) do update set
    stock_number = excluded.stock_number,
    year = excluded.year,
    make = excluded.make,
    model = excluded.model,
    purchase_source = coalesce(public.vehicles.purchase_source, 'Rental Fleet'),
    business_use = 'rental',
    fund_allocation = excluded.fund_allocation,
    acquisition_notes = coalesce(public.vehicles.acquisition_notes, excluded.acquisition_notes);

insert into public.vehicles (
    stock_number,
    vin,
    year,
    make,
    model,
    purchase_date,
    purchase_source,
    status,
    business_use,
    fund_allocation,
    acquisition_notes
) values (
    'KW558580',
    '1C4HJXDG4KW558580',
    2019,
    'Jeep',
    'Wrangler',
    current_date,
    'Rental Fleet',
    'IN_INVENTORY',
    'rental',
    'F2',
    'Rental fleet import from rental_vehicles.xlsx; unit=KW558580_2019 JEEP WRANGLER UNLIMITED SPORT S; purchase_date placeholder=current_date'
)
on conflict (vin) do update set
    stock_number = excluded.stock_number,
    year = excluded.year,
    make = excluded.make,
    model = excluded.model,
    purchase_source = coalesce(public.vehicles.purchase_source, 'Rental Fleet'),
    business_use = 'rental',
    fund_allocation = excluded.fund_allocation,
    acquisition_notes = coalesce(public.vehicles.acquisition_notes, excluded.acquisition_notes);

insert into public.vehicles (
    stock_number,
    vin,
    year,
    make,
    model,
    purchase_date,
    purchase_source,
    status,
    business_use,
    fund_allocation,
    acquisition_notes
) values (
    'LY238781',
    '3N1AB8DV3LY238781',
    2020,
    'Nissan',
    'Sentra',
    current_date,
    'Rental Fleet',
    'IN_INVENTORY',
    'rental',
    'F2',
    'Rental fleet import from rental_vehicles.xlsx; unit=LY238781_2020 Nissan Sentra SR Sedan 4D; purchase_date placeholder=current_date'
)
on conflict (vin) do update set
    stock_number = excluded.stock_number,
    year = excluded.year,
    make = excluded.make,
    model = excluded.model,
    purchase_source = coalesce(public.vehicles.purchase_source, 'Rental Fleet'),
    business_use = 'rental',
    fund_allocation = excluded.fund_allocation,
    acquisition_notes = coalesce(public.vehicles.acquisition_notes, excluded.acquisition_notes);

insert into public.vehicles (
    stock_number,
    vin,
    year,
    make,
    model,
    purchase_date,
    purchase_source,
    status,
    business_use,
    fund_allocation,
    acquisition_notes
) values (
    'SU117149',
    '1GT40BDD6SU117149',
    2025,
    'GMC',
    'Hummer',
    current_date,
    'Rental Fleet',
    'IN_INVENTORY',
    'rental',
    'AA',
    'Rental fleet import from rental_vehicles.xlsx; unit=SU117149_2025 GMC HUMMER EV Pickup; purchase_date placeholder=current_date'
)
on conflict (vin) do update set
    stock_number = excluded.stock_number,
    year = excluded.year,
    make = excluded.make,
    model = excluded.model,
    purchase_source = coalesce(public.vehicles.purchase_source, 'Rental Fleet'),
    business_use = 'rental',
    fund_allocation = excluded.fund_allocation,
    acquisition_notes = coalesce(public.vehicles.acquisition_notes, excluded.acquisition_notes);

insert into public.vehicles (
    stock_number,
    vin,
    year,
    make,
    model,
    purchase_date,
    purchase_source,
    status,
    business_use,
    fund_allocation,
    acquisition_notes
) values (
    'JF342602',
    'WDC0J4KBXJF342602',
    2018,
    'Mercedes-Benz',
    'GLC',
    current_date,
    'Rental Fleet',
    'IN_INVENTORY',
    'rental',
    'F1',
    'Rental fleet import from rental_vehicles.xlsx; unit=JF342602_2018 MERCEDES-BENZ GLC 300 Coupe; purchase_date placeholder=current_date'
)
on conflict (vin) do update set
    stock_number = excluded.stock_number,
    year = excluded.year,
    make = excluded.make,
    model = excluded.model,
    purchase_source = coalesce(public.vehicles.purchase_source, 'Rental Fleet'),
    business_use = 'rental',
    fund_allocation = excluded.fund_allocation,
    acquisition_notes = coalesce(public.vehicles.acquisition_notes, excluded.acquisition_notes);

insert into public.vehicles (
    stock_number,
    vin,
    year,
    make,
    model,
    purchase_date,
    purchase_source,
    status,
    business_use,
    fund_allocation,
    acquisition_notes
) values (
    'JA063152',
    'WAUC4CF58JA063152',
    2018,
    'Audi',
    'S5',
    current_date,
    'Rental Fleet',
    'IN_INVENTORY',
    'rental',
    'F1',
    'Rental fleet import from rental_vehicles.xlsx; unit=JA063152_2018 Audi S5 Prestige Sedan 4D SILVER; purchase_date placeholder=current_date'
)
on conflict (vin) do update set
    stock_number = excluded.stock_number,
    year = excluded.year,
    make = excluded.make,
    model = excluded.model,
    purchase_source = coalesce(public.vehicles.purchase_source, 'Rental Fleet'),
    business_use = 'rental',
    fund_allocation = excluded.fund_allocation,
    acquisition_notes = coalesce(public.vehicles.acquisition_notes, excluded.acquisition_notes);

insert into public.vehicles (
    stock_number,
    vin,
    year,
    make,
    model,
    purchase_date,
    purchase_source,
    status,
    business_use,
    fund_allocation,
    acquisition_notes
) values (
    'JW255356',
    '1C4HJXCN9JW255356',
    2018,
    'Jeep',
    'Wrangler',
    current_date,
    'Rental Fleet',
    'IN_INVENTORY',
    'rental',
    'F3',
    'Rental fleet import from rental_vehicles.xlsx; unit=2018 Jeep Wrangler All New Rubicon Sport Utility 2D; purchase_date placeholder=current_date'
)
on conflict (vin) do update set
    stock_number = excluded.stock_number,
    year = excluded.year,
    make = excluded.make,
    model = excluded.model,
    purchase_source = coalesce(public.vehicles.purchase_source, 'Rental Fleet'),
    business_use = 'rental',
    fund_allocation = excluded.fund_allocation,
    acquisition_notes = coalesce(public.vehicles.acquisition_notes, excluded.acquisition_notes);

commit;

-- Quick checks after import:
-- select count(*) from public.vehicles where business_use = 'rental';
-- select fund_allocation, count(*) from public.vehicles where business_use = 'rental' group by fund_allocation order by fund_allocation;
-- select vehicle_id, stock_number, vin, year, make, model, status, business_use, fund_allocation from public.vehicle_master_sheet where business_use = 'rental' order by fund_allocation, make, model;