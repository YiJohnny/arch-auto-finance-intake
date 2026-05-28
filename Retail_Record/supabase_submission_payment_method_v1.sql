alter table public.intake_submissions
drop constraint if exists intake_submissions_payment_method_check;

alter table public.intake_submissions
add constraint intake_submissions_payment_method_check
check (
    payment_method is null
    or payment_method in (
        'self_paid',
        'store_cash',
        'visa_1209',
        'visa_2829',
        'visa_3173',
        'visa_3675',
        'visa_3687',
        'visa_4647',
        'visa_6755',
        'visa_7647'
    )
);
