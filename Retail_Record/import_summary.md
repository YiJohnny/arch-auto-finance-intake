# Import Summary

- Source rows scanned: `250`
- Rows prepared for import: `121`
- Rows sent to manual review: `129`

## Source Status Counts

- `APPRAISAL`: `123`
- `SOLD`: `114`
- `IN INVENTORY`: `9`
- `INBOUND`: `2`
- `TRADE IN`: `2`

## Import Assumptions

- `APPRAISAL` rows are excluded from import by default.
- `IN INVENTORY` is mapped to `IN_INVENTORY`.
- `TRADE IN` is mapped to `IN_INVENTORY` with `purchase_source = 'Trade-In'`.
- `SOLD` rows use `Created Date` as a temporary `sale_date` because the export does not contain an explicit sold date.
- `SOLD` rows missing `Selling Price` are excluded and written to `import_review.csv`.
- Rows missing `Stock Number`, `VIN`, `Make`, `Model`, or `purchase_date` are excluded and written to `import_review.csv`.
