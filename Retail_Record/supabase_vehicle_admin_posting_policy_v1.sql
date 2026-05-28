-- Run this after supabase_review_posting_v1.sql.
--
-- Employee intake should not create rows in public.vehicles directly. Employees
-- store unmatched vehicle details on intake_submissions, then a reviewer creates
-- or links the vehicle when posting the approved submission to the ledger.

alter table public.vehicles enable row level security;

drop policy if exists "Authenticated users can view vehicles." on public.vehicles;
create policy "Authenticated users can view vehicles."
on public.vehicles
for select
to authenticated
using (true);

drop policy if exists "Reviewers can create vehicles." on public.vehicles;
create policy "Reviewers can create vehicles."
on public.vehicles
for insert
to authenticated
with check (public.is_intake_reviewer());

drop policy if exists "Reviewers can update vehicles." on public.vehicles;
create policy "Reviewers can update vehicles."
on public.vehicles
for update
to authenticated
using (public.is_intake_reviewer())
with check (public.is_intake_reviewer());
