-- Admin-controlled accounting category fields.
--
-- Employees do not choose these categories. AI may suggest one, but the final
-- accounting category is selected by a manager/accountant during review/posting.

alter table public.intake_submissions
add column if not exists ai_suggested_category text,
add column if not exists ai_suggested_vendor text,
add column if not exists accounting_category text;

alter table if exists public.general_ledger_entries
add column if not exists accounting_category text;

create index if not exists idx_intake_submissions_accounting_category
    on public.intake_submissions(accounting_category);

create index if not exists idx_intake_submissions_ai_suggested_category
    on public.intake_submissions(ai_suggested_category);

create index if not exists idx_general_ledger_entries_accounting_category
    on public.general_ledger_entries(accounting_category);
