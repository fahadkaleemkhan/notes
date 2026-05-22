# Due Bills — Proposed CSV Structure (slim)

Goal: total up pending dues + see what was bought. One row per product line; bill-level info repeats on each line of the same bill.

## Two output files, same schema

- `pending.csv` — only rows where the screenshot status is **Pending**
- `timed_out.csv` — only rows where status is **Timed Out**

(`status` dropped as a column since it's implied by the file.)

## Schema (both files)

| Column | Notes |
|---|---|
| `filename` | original `.png` name — anchors each bill |
| `folder` | `DUE BILLS` or `DUE BILLS 2026` |
| `bill_date` | parsed from filename (`YYYY-MM-DD`), blank for `Screenshot …` files |
| `patient_name` | from footer |
| `mrn` | medical record number (blank if not shown) |
| `amount` | `Rounded Net Amount` for the whole bill, in rupees (integer) — **same value on every line of that bill** |
| `created_by` | cashier |
| `product_name` | the item on this line |
| `qty` | integer |

To total dues per patient: dedupe by `filename`, then sum `amount`.
