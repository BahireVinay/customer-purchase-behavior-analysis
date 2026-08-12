-- Customer Purchase Behavior Analysis
-- Database: SQLite 3
-- The CSV files are the source data. This script creates the analytical tables.

DROP TABLE IF EXISTS customer_transactions;
DROP TABLE IF EXISTS customer_master;

CREATE TABLE customer_master (
    customer_id TEXT PRIMARY KEY,
    city TEXT NOT NULL,
    gender TEXT NOT NULL,
    age_group TEXT NOT NULL,
    acquisition_channel TEXT NOT NULL
);

CREATE TABLE customer_transactions (
    transaction_id TEXT PRIMARY KEY,
    customer_id TEXT NOT NULL,
    transaction_date DATE NOT NULL,
    product_category TEXT NOT NULL,
    product_name TEXT NOT NULL,
    quantity INTEGER NOT NULL,
    unit_price REAL NOT NULL,
    discount_pct REAL NOT NULL,
    discount_amount REAL NOT NULL,
    gross_amount REAL NOT NULL,
    net_amount REAL NOT NULL,
    payment_method TEXT NOT NULL,
    city TEXT NOT NULL,
    age_group TEXT NOT NULL,
    gender TEXT NOT NULL,
    acquisition_channel TEXT NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customer_master(customer_id)
);

-- Recommended validation checks
SELECT COUNT(*) AS transaction_count FROM customer_transactions;
SELECT COUNT(DISTINCT customer_id) AS unique_customers FROM customer_transactions;
SELECT MIN(transaction_date) AS first_transaction,
       MAX(transaction_date) AS last_transaction
FROM customer_transactions;
