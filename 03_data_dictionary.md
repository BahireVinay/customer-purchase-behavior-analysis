# Data Dictionary

## `customer_transactions.csv`

| Column | Description |
|---|---|
| transaction_id | Unique transaction identifier |
| customer_id | Unique customer identifier |
| transaction_date | Date of purchase |
| product_category | High-level product category |
| product_name | Product purchased |
| quantity | Number of units purchased |
| unit_price | Price per unit before discount |
| discount_pct | Discount percentage applied |
| discount_amount | Monetary discount |
| gross_amount | Quantity × unit price |
| net_amount | Gross amount - discount amount |
| payment_method | Payment method used |
| city | Customer city |
| age_group | Customer age band |
| gender | Customer gender |
| acquisition_channel | Channel through which customer was acquired |

## Analytical Definitions

- **Gross Revenue:** Sum of `gross_amount`.
- **Net Revenue:** Sum of `net_amount` after discounts.
- **Average Transaction Value:** Average `net_amount` per transaction.
- **Repeat Customer:** Customer with more than one transaction.
- **High-Value Customer:** Customer placed in the upper customer-spend segments based on total spend.
- **Active Customer:** Customer with at least one transaction in the selected period.

> Dataset is synthetic and intended for portfolio/learning purposes.
