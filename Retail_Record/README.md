# Retail Record

SQLite-first schema for a vehicle lifecycle accounting system.

## Core model

- `vehicles`: one row per vehicle, used as the master record.
- `vehicle_cost_ledger`: one row per lifecycle event or direct cost.
- `audit_log`: immutable change history for inserts and updates.
- `vehicle_profit_snapshot`: current COGS and gross profit by vehicle.

## Accounting logic

- A vehicle starts with one `ACQUISITION` entry using category `PURCHASE`.
- Every direct cost during inventory life is appended to `vehicle_cost_ledger`.
- COGS is the sum of non-voided entries with types `ACQUISITION`, `DIRECT_COST`, and `ADJUSTMENT`.
- Gross profit is `sale_price - total_cogs`.
- Voiding a bad entry is preferred over deleting it.

## Recommended workflow

1. Create the vehicle in `vehicles`.
2. Insert the initial purchase cost in `vehicle_cost_ledger`.
3. Append every direct vehicle cost as it happens.
4. When sold, update `vehicles.status`, `sale_date`, and `sale_price`.
5. Read `vehicle_profit_snapshot` for current COGS and gross profit.

## Example setup

```bash
sqlite3 retail_record.db < schema.sql
```

## Supabase / Postgres

- Use [supabase_schema_v1.sql](/Users/yisun/Documents/ArchAuto/Retail_Record/supabase_schema_v1.sql) in the Supabase SQL Editor.
- This version converts the original SQLite-first design into PostgreSQL syntax for Supabase.
- Run the full file once to create tables, triggers, indexes, and the profit snapshot view.
- If your project already has `supabase_schema_v1.sql` applied, run [supabase_migration_v2_status_history.sql](/Users/yisun/Documents/ArchAuto/Retail_Record/supabase_migration_v2_status_history.sql) to add `vehicle_status_history` and expanded lifecycle statuses.
- Run [supabase_migration_v3_relax_sale_date.sql](/Users/yisun/Documents/ArchAuto/Retail_Record/supabase_migration_v3_relax_sale_date.sql) if historical sold records do not have a trustworthy `sale_date`.
- Run [supabase_view_vehicle_master_sheet.sql](/Users/yisun/Documents/ArchAuto/Retail_Record/supabase_view_vehicle_master_sheet.sql) to create a day-to-day inventory management view.
- Run [supabase_view_quarter_dashboard.sql](/Users/yisun/Documents/ArchAuto/Retail_Record/supabase_view_quarter_dashboard.sql) to create a quarterly revenue / COGS / gross profit dashboard view.
- Run [supabase_view_inventory_dashboard.sql](/Users/yisun/Documents/ArchAuto/Retail_Record/supabase_view_inventory_dashboard.sql) to create a current inventory cost and aging dashboard view.
- Use [vehicle_detail_query_pack.sql](/Users/yisun/Documents/ArchAuto/Retail_Record/vehicle_detail_query_pack.sql) as a reusable single-vehicle lookup pack.

## Expense Intake MVP

Run [supabase_expense_intake_v1.sql](/Users/yisun/Documents/ArchAuto/Retail_Record/supabase_expense_intake_v1.sql) after the base Supabase schema is installed.
Then run [supabase_auth_profiles_v1.sql](/Users/yisun/Documents/ArchAuto/Retail_Record/supabase_auth_profiles_v1.sql) to allow authenticated employees to create their own `app_profiles` row during signup or first login.
Run [supabase_intake_unmatched_vehicle_v1.sql](/Users/yisun/Documents/ArchAuto/Retail_Record/supabase_intake_unmatched_vehicle_v1.sql) to support manual vehicle fallback and vehicle business use.
Run [supabase_review_posting_v1.sql](/Users/yisun/Documents/ArchAuto/Retail_Record/supabase_review_posting_v1.sql) to support admin review, general ledger entries, and posting references.

This migration creates the first employee-facing intake framework:

- `app_profiles`: authenticated staff profiles and roles.
- `intake_submissions`: employee income/expense submissions.
- `intake_documents`: uploaded receipt/photo/PDF metadata.
- `intake_audit_log`: status and document activity history.
- `intake-documents`: private Supabase Storage bucket for sensitive documents.

The first version supports this workflow:

1. Employee selects `repair`, `rental`, `retail`, or `general`.
2. If `repair`, employee also selects `rental_vehicle`, `retail_inventory`, `walk_in`, or `shop_general`.
3. Employee selects `income` or `expense`.
4. Employee uploads a receipt photo or PDF and enters basic transaction details.
5. Manager or accountant reviews the submission.
6. Approved submissions can later be converted into accounting categories and journal entries.

Roles:

- `employee`: create and view own submissions.
- `manager`: review submissions.
- `accountant`: review and prepare future accounting posting.
- `admin`: manage profiles and access all intake records.

Bootstrap note: after creating the first Supabase Auth user, manually insert that user into `public.app_profiles` as `admin` from the Supabase SQL Editor. After that, admins can manage additional profiles through the app.

## Import Notes

- `All Inventory.xlsx` is suitable as a source for `vehicles` plus opening cost balances.
- Recommended import approach:
  - `Vehicle Cost` -> `vehicle_cost_ledger` as `ACQUISITION / PURCHASE`
  - `Total Cost - Vehicle Cost` -> `vehicle_cost_ledger` as `DIRECT_COST / OTHER_DIRECT_COST`
  - `Inventory Status` -> map into your own `vehicles.status` values instead of copying source values blindly

## Notes

- This design is compatible with a future move to PostgreSQL.
- DealerCenter IDs can be stored in `vehicles.dealercenter_deal_id` and `vehicle_cost_ledger.source_record_id`.
- `SG&A`, `Interest`, and `Tax` should live in separate tables later, not in `vehicle_cost_ledger`.
