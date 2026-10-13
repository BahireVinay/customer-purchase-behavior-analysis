# Customer Purchase Behaviour Analysis

An end-to-end analysis of **1.07 million real transaction lines** from a UK online retailer: cleaning the data, measuring customer behaviour with SQL and pandas, segmenting customers, flagging unusually large orders, and reading the monthly revenue trend.

![Monthly revenue](images/monthly_revenue.png)

## Headline findings
| Finding | Number |
|---|---|
| Repeat buyers (2+ orders) as a share of customers / of revenue | **72.4% / 96.7%** |
| One-time buyers as a share of customers / of revenue | 27.6% / 3.3% |
| Revenue from the top value quartile ("Platinum") | **81.5%** |
| Mean vs median customer spend | £2,917 vs about £856 |
| Invoices flagged as unusually large (IQR rule) | 2,861 of 36,594 (7.8%), carrying 39.5% of revenue |
| September to November share of 2010 customer revenue | about 36% |

All revenue figures are **gross sales attributed to an identified customer** (£17.07M across 5,852 customers). See *Assumptions and limitations*.

## Business questions
1. Who are the valuable customers, and how concentrated is revenue?
2. Do customers come back, and what does a repeat buyer look like?
3. Which orders are unusual enough to inspect?
4. When does revenue peak, and does the pattern repeat?

## Data
- **Source:** Online Retail II (UCI Machine Learning Repository / Kaggle mirror) - [add link and licence]
- **Content:** 1,067,371 invoice lines, 8 columns, 2009-12-01 to 2011-12-09, prices in GBP
- **Not included in this repo** (the CSV is about 95 MB). Download it and place it next to the notebook.

## Tools
Python (pandas, NumPy, Matplotlib), SQLite via `sqlite3`, Jupyter.

## Approach

### 1. Audit first, then clean
Every cleaning rule was applied one at a time and logged (rows before, rows after, why). The waterfall reconciles exactly: 1,067,371 - 290,794 = 776,577.

| Step | Rows removed | Rule | Why |
|---|---|---|---|
| Exact duplicates | 34,335 | identical in all 8 columns; first copy kept | no line ID exists to separate a repeat scan from a double-record, so this is a judgement call |
| Missing Customer ID | 235,151 | set aside (243,007 before de-duplication, 22.8% of raw rows) | cannot be attributed to a customer; kept in a separate frame |
| Cancellations (Invoice starts with "C") | 18,390 | moved to a `returns` table | returns are information, not noise |
| Price = 0 | 70 | dropped | adds no revenue and is not a sale |
| Non-product StockCodes | 2,848 | moved to a `fees` table (POST 1,803, M 681, C2 248, ADJUST, BANK CHARGES, TEST codes, ...) | charges and test rows are not merchandise |
| **Final sales table** | | **776,577 lines** | |

Other things found in the audit: negative-quantity rows that are not "C" invoices all have price 0 and no customer ID (descriptions such as "smashed", "lost", "missing") and look like stock write-offs; the only negative prices are five "Adjust bad debt" rows with no customer ID.

### 2. Per-customer metrics (SQL + pandas)
Cleaned data was loaded into SQLite and aggregated per customer.

| Metric | Definition | Question it answers |
|---|---|---|
| Total spend | sum of price x quantity | who brings in the money? |
| Order frequency | distinct invoices | do customers come back? |
| Average order value | spend / invoices | big or small baskets? |
| Recency | days from last purchase to the dataset's end | who is drifting away? |
| Returns | count and value from cancellations | where is revenue leaking? |

### 3. Segmentation
- **Repeat vs one-time:** more than one distinct invoice = repeat.
- **Value tiers:** quartiles of total spend (Bronze / Silver / Gold / Platinum), cut-offs at £339.50, £856.01 and £2,240.90.

### 4. Outliers
IQR rule on **invoice totals** (not line items): Q1 = £158.63, Q3 = £473.88, upper fence = £946.76. Orders are flagged, never deleted.

### 5. Monthly revenue
Monthly customer revenue, with the partial month (December 2011, data ends on the 9th) excluded from the chart.

## What the data says
- **Retention matters most.** One-time buyers are over a quarter of customers but only 3.3% of revenue. Turning a first purchase into a second one is the biggest lever.
- **Revenue is highly concentrated.** The top quartile of customers generates 81.5% of revenue, so losing a few top accounts would be costly. Mean spend is more than three times the median.
- **Strong seasonality.** September to November produce roughly 36% of annual revenue in 2010. November peaks at about £1.16M (2010) and £1.14M (2011); September 2011 is 16.5% above September 2010.
- **Large orders are not all equal.** The largest flagged invoice (81 thousand units, £168,469.60) was cancelled 12 minutes later by a matching cancellation invoice, a reminder to check returns before trusting a big number.

## Assumptions and limitations
- **Gross vs net:** spend is gross sales. Returns are reported separately per customer and are not subtracted from `total_spent`, so a few very large cancelled orders still inflate gross figures for their customers.
- **13.1% of valid revenue has no customer ID** and is excluded from every customer-level metric and from the monthly chart.
- **76 customers have returns but no sales** in the cleaned data; their returns are not in the customer table.
- **Duplicates:** dropped as exact copies, but the data cannot prove they are errors. [Add the with/without revenue difference once the sensitivity check is done.]
- **Recency** is measured from the dataset's last date, not today's date.
- The retailer appears to serve many trade customers, so some very large orders may be genuine.
- Product categories and cross-selling were left out of scope.

## Repository layout
```
customer-purchase-analysis/
├── customer_purchase_analysis.ipynb   # full analysis, runs top to bottom
├── outputs/                           # waterfall, customer_metrics, monthly_revenue, flagged_invoices (CSV)
├── images/                            # charts used in this README
├── requirements.txt
└── README.md
```

## How to run
1. Download the dataset (link above) and save it as `online_retail_II.csv` in the project folder.
2. `pip install -r requirements.txt`
3. Open the notebook and choose **Restart kernel and Run All**.

Developed with Python [version] and pandas [version].
