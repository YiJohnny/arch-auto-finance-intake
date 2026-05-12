# All Inventory Import Mapping

This file maps `All Inventory.xlsx` into the current database design.

## Vehicles

Use these columns to populate `public.vehicles`:

| Excel Column | Database Column | Notes |
| --- | --- | --- |
| `Stock Number` | `stock_number` | Required. If blank, review manually before import. |
| `VIN` | `vin` | Required and unique. |
| `Year` | `year` | Cast to integer. |
| `Make` | `make` | Required. |
| `Model` | `model` | Required. |
| `Trim` | `trim` | Optional. |
| `Odometer` | `mileage` | Cast to integer. |
| `Exterior Color` | `color` | Interior color is not modeled yet. |
| `Date In Stock` | `purchase_date` | Fallback to `Created Date` if missing. |
| `Inventory Status` | `status` | Map into your own lifecycle statuses. |
| `Selling Price` | `sale_price` | Only when source row is already sold. |
| `Created Date` | `created_at` | Optional if importing historical timestamps later. |

## Suggested Status Mapping

Recommended first-pass mapping from the Excel export:

| Source Status | Target Status |
| --- | --- |
| `SOLD` | `SOLD` |
| `APPRAISAL` | `IN_BOUND` |
| blank / unknown active statuses | `IN_INVENTORY` |

Refine this mapping after you review more rows.

## Vehicle Cost Ledger

For each imported vehicle, create at least these ledger rows:

1. `Vehicle Cost` -> `ACQUISITION / PURCHASE`
2. `Total Cost - Vehicle Cost` -> `DIRECT_COST / OTHER_DIRECT_COST` if the difference is not zero

Suggested description for the second row:

`Imported historical direct costs from legacy inventory summary`

## Fields Not Yet Mapped

These columns are useful but are not yet part of the current schema:

- `Interior Color`
- `Asking Price`
- `Advertising Price`
- `VehicleSaleType`
- `Special Price`
- `FloorPrice`
- `Vehicle Price`
- `BuyNowPrice`
- `StartingBidPrice`
- `BidIncrement`
- `Total Gross`
- `Last Appraised Value`
- `Last Appraisal Date`
- `Custom Status`

Keep them in the raw export for now. We can add selected fields later if they prove useful.
