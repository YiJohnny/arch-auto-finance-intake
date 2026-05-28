-- Fix: audit_vehicle_change trigger was not SECURITY DEFINER, causing employee
-- vehicle inserts to fail when RLS on audit_log blocks non-reviewer inserts.
-- The trigger runs in the context of the calling user, so employees couldn't
-- write to audit_log, which rolled back the entire vehicle INSERT transaction.
--
-- Making the function SECURITY DEFINER lets it run as the DB owner, so audit
-- log writes succeed regardless of who triggered the vehicle insert.

create or replace function public.audit_vehicle_change()
returns trigger
language plpgsql
security definer
set search_path = public
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
