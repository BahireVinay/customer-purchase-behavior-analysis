# Customer Purchase Behavior Analysis

**Tools:** SQL (SQLite), Microsoft Excel, Data Analysis  
**Dataset:** Synthetic customer transaction dataset  
**Transactions:** 2,200  
**Customers:** 250  
**Period:** January 2025 – December 2025

## Project Overview

This project analyzes customer transaction data to identify purchasing patterns, sales trends, high-value customers, repeat-purchase behavior, product/category performance and customer acquisition patterns.

The project was designed as a practical portfolio project for an entry-level Data Analyst role. It demonstrates how raw transaction data can be cleaned, validated, aggregated and converted into business-focused insights.

## Business Questions

- What are the overall transaction and revenue KPIs?
- Which product categories and products generate the most revenue?
- How does revenue change month by month?
- Which customers are the highest value?
- What percentage of customers are repeat buyers?
- Which cities contribute the most revenue?
- Which acquisition channels generate the strongest revenue?
- Which payment methods are most commonly used?
- Which age groups contribute the most revenue?
- How does discounting relate to transaction value?

## Repository Structure

```text
customer-purchase-behavior-analysis/
│
├── customer_transactions.csv
├── customer_master.csv
├── customer_purchase_analysis.db
├── customer_purchase_behavior_analysis.xlsx
│
├── 01_schema.sql
├── 02_analysis_queries.sql
├── 03_data_dictionary.md
├── 04_key_findings.md
└── README.md
```

## Workflow

```text
Synthetic Raw Data
       ↓
Data Validation & Cleaning
       ↓
SQL Aggregation & Analysis
       ↓
Customer / Product / Category Analysis
       ↓
Excel Summary Tables & Charts
       ↓
Business Insights & Recommendations
```

## SQL Analysis

The SQL scripts contain queries for:

- Overall KPIs
- Monthly sales trends
- Category and product performance
- High-value customers
- Purchase frequency
- Repeat vs one-time customers
- City performance
- Acquisition channel analysis
- Payment method analysis
- Age-group analysis
- Discount-band analysis
- Customer/category combinations

### Running the SQL

The easiest option is to open `customer_purchase_analysis.db` using any SQLite-compatible database viewer.

Alternatively, use the CSV files and execute `01_schema.sql` followed by the queries in `02_analysis_queries.sql`.

## Excel Analysis

The workbook `customer_purchase_behavior_analysis.xlsx` contains:

- KPI Summary
- Transaction-level data
- Customer Analysis
- Monthly Trend
- Category Analysis
- Product Analysis
- City Analysis
- Acquisition Channel Analysis
- Payment Analysis
- Age Group Analysis

Charts are included for monthly revenue, category revenue and acquisition-channel revenue mix.

## Key Findings

See [`04_key_findings.md`](04_key_findings.md) for the summarized business findings and recommendations.

## Data Quality Checks

The project validates:

- Transaction count
- Unique customer count
- Date range
- Revenue calculations
- Duplicate transaction identifiers
- Customer-level aggregation
- Category and product-level totals


