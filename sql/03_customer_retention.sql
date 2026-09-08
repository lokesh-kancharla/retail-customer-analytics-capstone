-- Customer retention and repeat purchase analysis

-- 1. Customer purchase frequency and repeat status
WITH customer_orders AS (
    SELECT
        customer_id,
        MIN(order_date) AS first_purchase_date,
        MAX(order_date) AS last_purchase_date,
        COUNT(DISTINCT order_id) AS order_count,
        SUM(quantity * unit_price * (1 - discount_pct)) AS lifetime_revenue
    FROM retail_transactions
    GROUP BY customer_id
)
SELECT
    customer_id,
    first_purchase_date,
    last_purchase_date,
    order_count,
    ROUND(lifetime_revenue, 2) AS lifetime_revenue,
    CASE WHEN order_count > 1 THEN 'Repeat' ELSE 'One-Time' END AS customer_type
FROM customer_orders
ORDER BY lifetime_revenue DESC;

-- 2. Overall repeat customer rate
WITH customer_orders AS (
    SELECT customer_id, COUNT(DISTINCT order_id) AS order_count
    FROM retail_transactions
    GROUP BY customer_id
)
SELECT
    COUNT(*) AS total_customers,
    SUM(CASE WHEN order_count > 1 THEN 1 ELSE 0 END) AS repeat_customers,
    ROUND(
        SUM(CASE WHEN order_count > 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS repeat_customer_rate_pct
FROM customer_orders;

-- 3. Cohort assignment and monthly activity
WITH first_purchase AS (
    SELECT
        customer_id,
        DATE_TRUNC('month', MIN(order_date)) AS cohort_month
    FROM retail_transactions
    GROUP BY customer_id
),
activity AS (
    SELECT
        r.customer_id,
        f.cohort_month,
        DATE_TRUNC('month', r.order_date) AS activity_month
    FROM retail_transactions r
    JOIN first_purchase f ON r.customer_id = f.customer_id
    GROUP BY r.customer_id, f.cohort_month, DATE_TRUNC('month', r.order_date)
),
cohort_activity AS (
    SELECT
        cohort_month,
        activity_month,
        (
            EXTRACT(YEAR FROM activity_month) - EXTRACT(YEAR FROM cohort_month)
        ) * 12 + (
            EXTRACT(MONTH FROM activity_month) - EXTRACT(MONTH FROM cohort_month)
        ) AS month_number,
        COUNT(DISTINCT customer_id) AS active_customers
    FROM activity
    GROUP BY cohort_month, activity_month
),
cohort_size AS (
    SELECT cohort_month, COUNT(DISTINCT customer_id) AS cohort_customers
    FROM first_purchase
    GROUP BY cohort_month
)
SELECT
    c.cohort_month,
    c.month_number,
    c.active_customers,
    s.cohort_customers,
    ROUND(c.active_customers * 100.0 / NULLIF(s.cohort_customers, 0), 2) AS retention_rate_pct
FROM cohort_activity c
JOIN cohort_size s USING (cohort_month)
ORDER BY c.cohort_month, c.month_number;

-- 4. Days between purchases for repeat customers
WITH ordered_purchases AS (
    SELECT
        customer_id,
        order_date,
        LAG(order_date) OVER (PARTITION BY customer_id ORDER BY order_date) AS prior_order_date
    FROM retail_transactions
)
SELECT
    customer_id,
    order_date,
    prior_order_date,
    order_date - prior_order_date AS days_since_prior_purchase
FROM ordered_purchases
WHERE prior_order_date IS NOT NULL
ORDER BY customer_id, order_date;
