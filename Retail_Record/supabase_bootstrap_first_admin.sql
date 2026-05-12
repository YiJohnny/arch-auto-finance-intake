-- Replace the email below with the email address you used to sign up in the app.
-- This maps that Supabase Auth user to the existing public.users row #1
-- and gives the account full admin access, which includes manager/accountant review permissions.

insert into public.app_profiles (
    profile_id,
    full_name,
    email,
    role,
    is_active
)
select
    au.id,
    coalesce(u.full_name, au.raw_user_meta_data->>'full_name', au.email),
    au.email,
    'admin',
    true
from auth.users au
left join public.users u
    on u.user_id = 1
where au.email = 'sunyijohnny@gmail.com'
on conflict (profile_id) do update
set
    full_name = excluded.full_name,
    email = excluded.email,
    role = 'admin',
    is_active = true,
    updated_at = now();
