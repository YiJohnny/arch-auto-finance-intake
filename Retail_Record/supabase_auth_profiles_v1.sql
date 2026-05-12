drop policy if exists "Users can create their own employee profile." on public.app_profiles;
create policy "Users can create their own employee profile."
on public.app_profiles
for insert
to authenticated
with check (
    profile_id = auth.uid()
    and role = 'employee'
);

drop policy if exists "Users can update their own basic profile." on public.app_profiles;
