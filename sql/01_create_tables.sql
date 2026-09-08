DROP TABLE IF EXISTS retail_transactions;

CREATE TABLE retail_transactions (
    order_id VARCHAR(20) PRIMARY KEY,
    order_date DATE NOT NULL,
    customer_id VARCHAR(20) NOT NULL,
    customer_segment VARCHAR(50),
    region VARCHAR(50),
    product_id VARCHAR(20),
    product_name VARCHAR(100),
    category VARCHAR(100),
    quantity INT,
    unit_price DECIMAL(12,2),
    unit_cost DECIMAL(12,2),
    discount_pct DECIMAL(6,4)
);

-- Derived financial metrics are calculated in analysis queries so the raw table
-- remains close to the source transaction grain.
