-- Fix: vehicle inserts create a vehicle_status_history row through a trigger.
-- If RLS is enabled on vehicle_status_history, that trigger insert can be
-- blocked even though the reviewer is allowed to create the vehicle.
--
-- Run this in Supabase SQL Editor. It makes the trigger function run as the
-- database owner, so the automatic status-history row can be written safely.

create or replace function public.sync_vehicle_status_history()
returns trigger
language plpgsql
security definer
set search_path = public
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

drop policy if exists "Reviewers can view vehicle status history." on public.vehicle_status_history;
create policy "Reviewers can view vehicle status history."
on public.vehicle_status_history
for select
to authenticated
using (public.is_intake_reviewer());
