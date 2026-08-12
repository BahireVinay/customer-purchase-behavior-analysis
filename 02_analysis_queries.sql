-- Customer Purchase Behavior Analysis
-- SQLite-compatible analytical queries

-- 1. Overall business KPIs
SELECT
    COUNT(*) AS total_transactions,
    COUNT(DISTINCT customer_id) AS unique_customers,
    SUM(quantity) AS units_sold,
    ROUND(SUM(gross_amount), 2) AS gross_revenue,
    ROUND(SUM(net_amount), 2) AS net_revenue,
    ROUND(AVG(net_amount), 2) AS avg_transaction_value
FROM customer_transactions;


-- 2. Monthly sales trend
SELECT
    strftime('%Y-%m', transaction_date) AS month,
    COUNT(*) AS transactions,
    COUNT(DISTINCT customer_id) AS active_customers,
    ROUND(SUM(net_amount), 2) AS net_revenue,
    ROUND(AVG(net_amount), 2) AS avg_transaction_value
FROM customer_transactions
GROUP BY strftime('%Y-%m', transaction_date)
ORDER BY month;


-- 3. Category performance
SELECT
    product_category,
    COUNT(*) AS transactions,
    SUM(quantity) AS units_sold,
    ROUND(SUM(net_amount), 2) AS net_revenue,
    ROUND(AVG(net_amount), 2) AS avg_transaction_value
FROM customer_transactions
GROUP BY product_category
ORDER BY net_revenue DESC;


-- 4. Product performance
SELECT
    product_name,
    product_category,
    SUM(quantity) AS units_sold,
    ROUND(SUM(net_amount), 2) AS net_revenue
FROM customer_transactions
GROUP BY product_name, product_category
ORDER BY net_revenue DESC;


-- 5. High-value customers
SELECT
    customer_id,
    COUNT(*) AS transaction_count,
    SUM(quantity) AS units_purchased,
    ROUND(SUM(net_amount), 2) AS customer_revenue,
    ROUND(AVG(net_amount), 2) AS avg_order_value
FROM customer_transactions
GROUP BY customer_id
ORDER BY customer_revenue DESC
LIMIT 20;


-- 6. Customer purchase frequency distribution
WITH customer_frequency AS (
    SELECT customer_id, COUNT(*) AS purchase_count
    FROM customer_transactions
    GROUP BY customer_id
)
SELECT
    CASE
        WHEN purchase_count = 1 THEN '1 purchase'
        WHEN purchase_count BETWEEN 2 AND 4 THEN '2-4 purchases'
        WHEN purchase_count BETWEEN 5 AND 9 THEN '5-9 purchases'
        ELSE '10+ purchases'
    END AS purchase_frequency_band,
    COUNT(*) AS customers
FROM customer_frequency
GROUP BY purchase_frequency_band
ORDER BY customers DESC;


-- 7. Revenue by city
SELECT
    city,
    COUNT(DISTINCT customer_id) AS customers,
    COUNT(*) AS transactions,
    ROUND(SUM(net_amount), 2) AS net_revenue
FROM customer_transactions
GROUP BY city
ORDER BY net_revenue DESC;


-- 8. Revenue by acquisition channel
SELECT
    acquisition_channel,
    COUNT(DISTINCT customer_id) AS customers,
    COUNT(*) AS transactions,
    ROUND(SUM(net_amount), 2) AS net_revenue,
    ROUND(AVG(net_amount), 2) AS avg_order_value
FROM customer_transactions
GROUP BY acquisition_channel
ORDER BY net_revenue DESC;


-- 9. Payment method behavior
SELECT
    payment_method,
    COUNT(*) AS transactions,
    ROUND(SUM(net_amount), 2) AS net_revenue,
    ROUND(AVG(net_amount), 2) AS avg_order_value
FROM customer_transactions
GROUP BY payment_method
ORDER BY net_revenue DESC;


-- 10. Age-group behavior
SELECT
    age_group,
    COUNT(DISTINCT customer_id) AS customers,
    COUNT(*) AS transactions,
    ROUND(SUM(net_amount), 2) AS net_revenue,
    ROUND(AVG(net_amount), 2) AS avg_order_value
FROM customer_transactions
GROUP BY age_group
ORDER BY net_revenue DESC;


-- 11. Repeat vs one-time customers
WITH customer_summary AS (
    SELECT customer_id, COUNT(*) AS purchases
    FROM customer_transactions
    GROUP BY customer_id
)
SELECT
    CASE WHEN purchases = 1 THEN 'One-time' ELSE 'Repeat' END AS customer_type,
    COUNT(*) AS customers,
    ROUND(AVG(purchases), 2) AS avg_purchases
FROM customer_summary
GROUP BY customer_type;


-- 12. Customers with strong repeat behavior
SELECT
    customer_id,
    COUNT(*) AS purchases,
    ROUND(SUM(net_amount), 2) AS revenue
FROM customer_transactions
GROUP BY customer_id
HAVING COUNT(*) >= 10
ORDER BY purchases DESC, revenue DESC;


-- 13. Discount impact
SELECT
    CASE
        WHEN discount_pct = 0 THEN 'No Discount'
        WHEN discount_pct <= 10 THEN '1-10%'
        ELSE '11%+'
    END AS discount_band,
    COUNT(*) AS transactions,
    ROUND(AVG(net_amount), 2) AS avg_order_value,
    ROUND(SUM(net_amount), 2) AS net_revenue
FROM customer_transactions
GROUP BY discount_band
ORDER BY net_revenue DESC;


-- 14. Monthly category trend
SELECT
    strftime('%Y-%m', transaction_date) AS month,
    product_category,
    ROUND(SUM(net_amount), 2) AS net_revenue
FROM customer_transactions
GROUP BY month, product_category
ORDER BY month, net_revenue DESC;


-- 15. Top 10 customer/category combinations
SELECT
    customer_id,
    product_category,
    COUNT(*) AS purchases,
    ROUND(SUM(net_amount), 2) AS revenue
FROM customer_transactions
GROUP BY customer_id, product_category
ORDER BY revenue DESC
LIMIT 10;
