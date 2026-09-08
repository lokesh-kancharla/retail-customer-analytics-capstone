-- Retail Customer Analytics Capstone
-- Core business analysis queries

WITH sales AS (
    SELECT
        *,
        quantity * unit_price AS gross_revenue,
        quantity * unit_price * discount_pct AS discount_amount,
        quantity * unit_price * (1 - discount_pct) AS net_revenue,
        quantity * unit_cost AS total_cost,
        quantity * unit_price * (1 - discount_pct) - quantity * unit_cost AS profit
    FROM retail_transactions
)

-- 1. Monthly revenue and profit trend
SELECT
    DATE_TRUNC('month', order_date) AS order_month,
    ROUND(SUM(net_revenue), 2) AS revenue,
    ROUND(SUM(profit), 2) AS profit,
    ROUND(SUM(profit) / NULLIF(SUM(net_revenue), 0) * 100, 2) AS profit_margin_pct,
    COUNT(DISTINCT order_id) AS orders,
    COUNT(DISTINCT customer_id) AS customers
FROM sales
GROUP BY 1
ORDER BY 1;

-- 2. Category performance
WITH sales AS (
    SELECT
        *,
        quantity * unit_price * (1 - discount_pct) AS net_revenue,
        quantity * unit_price * (1 - discount_pct) - quantity * unit_cost AS profit
    FROM retail_transactions
)
SELECT
    category,
    ROUND(SUM(net_revenue), 2) AS revenue,
    ROUND(SUM(profit), 2) AS profit,
    ROUND(SUM(profit) / NULLIF(SUM(net_revenue), 0) * 100, 2) AS profit_margin_pct,
    SUM(quantity) AS units_sold
FROM sales
GROUP BY category
ORDER BY revenue DESC;

-- 3. Top products by revenue and profitability
WITH sales AS (
    SELECT
        *,
        quantity * unit_price * (1 - discount_pct) AS net_revenue,
        quantity * unit_price * (1 - discount_pct) - quantity * unit_cost AS profit
    FROM retail_transactions
)
SELECT
    product_name,
    category,
    ROUND(SUM(net_revenue), 2) AS revenue,
    ROUND(SUM(profit), 2) AS profit,
    SUM(quantity) AS units_sold,
    ROUND(SUM(profit) / NULLIF(SUM(net_revenue), 0) * 100, 2) AS profit_margin_pct
FROM sales
GROUP BY product_name, category
ORDER BY revenue DESC;

-- 4. Regional performance
WITH sales AS (
    SELECT
        *,
        quantity * unit_price * (1 - discount_pct) AS net_revenue,
        quantity * unit_price * (1 - discount_pct) - quantity * unit_cost AS profit
    FROM retail_transactions
)
SELECT
    region,
    ROUND(SUM(net_revenue), 2) AS revenue,
    ROUND(SUM(profit), 2) AS profit,
    COUNT(DISTINCT order_id) AS orders,
    COUNT(DISTINCT customer_id) AS customers,
    ROUND(SUM(net_revenue) / NULLIF(COUNT(DISTINCT order_id), 0), 2) AS average_order_value
FROM sales
GROUP BY region
ORDER BY revenue DESC;

-- 5. Top customers by lifetime revenue
WITH customer_sales AS (
    SELECT
        customer_id,
        customer_segment,
        COUNT(DISTINCT order_id) AS orders,
        SUM(quantity * unit_price * (1 - discount_pct)) AS lifetime_revenue,
        SUM(quantity * unit_price * (1 - discount_pct) - quantity * unit_cost) AS lifetime_profit
    FROM retail_transactions
    GROUP BY customer_id, customer_segment
)
SELECT
    customer_id,
    customer_segment,
    orders,
    ROUND(lifetime_revenue, 2) AS lifetime_revenue,
    ROUND(lifetime_profit, 2) AS lifetime_profit,
    ROUND(lifetime_revenue / NULLIF(orders, 0), 2) AS average_order_value
FROM customer_sales
ORDER BY lifetime_revenue DESC;
