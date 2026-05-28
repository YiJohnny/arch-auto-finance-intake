-- Store cash ledger.
--
-- This tracks cash movements separately from vehicle/general profit ledgers.
-- Store Cash expenses still post to vehicle_cost_ledger or general_ledger_entries,
-- then also create a cash_account_ledger row so the cash balance can be monitored.

create table if not exists public.cash_account_ledger (
    cash_entry_id bigint generated always as identity primary key,
    entry_date date not null,
    cash_account text not null default 'store_cash'
        check (cash_account in ('store_cash')),
    direction text not null
        check (direction in ('in', 'out')),
    amount numeric(12, 2) not null check (amount > 0),
    category text not null
        check (category in (
            'CASH_TRANSFER_IN',
            'CASH_TRANSFER_OUT',
            'EXPENSE_PAYMENT',
            'REIMBURSEMENT_PAYMENT',
            'INCOME_DEPOSIT',
            'CASH_ADJUSTMENT'
        )),
    description text,
    source_system text not null default 'MANUAL',
    source_record_id text,
    created_by uuid references public.app_profiles(profile_id) on delete restrict,
    created_at timestamptz not null default now(),
    unique (source_system, source_record_id)
);

create index if not exists idx_cash_account_ledger_entry_date
    on public.cash_account_ledger(entry_date desc);

create index if not exists idx_cash_account_ledger_category
    on public.cash_account_ledger(category);

alter table public.cash_account_ledger enable row level security;

drop policy if exists "Reviewers can view cash account ledger." on public.cash_account_ledger;
create policy "Reviewers can view cash account ledger."
on public.cash_account_ledger
for select
to authenticated
using (public.is_intake_reviewer());

drop policy if exists "Reviewers can create cash account ledger entries." on public.cash_account_ledger;
create policy "Reviewers can create cash account ledger entries."
on public.cash_account_ledger
for insert
to authenticated
with check (public.is_intake_reviewer());

create or replace view public.store_cash_balance as
select
    cash_account,
    coalesce(sum(
        case
            when direction = 'in' then amount
            when direction = 'out' then -amount
            else 0
        end
    ), 0)::numeric(12, 2) as balance
from public.cash_account_ledger
group by cash_account;
