# Power BI Dashboard Specification

## Goal

Create an executive-ready dashboard that answers three questions:

1. Is revenue and profit growing?
2. Which customers and segments should the business retain?
3. Which products and categories create profitable growth?

## Recommended Data Model

Use `retail_transactions_clean.csv` as the fact table.

Recommended dimensions:

- Date
- Customer
- Product
- Region

Relationships should be one-to-many from each dimension to the transaction fact table.

## Core DAX Measures

```DAX
Total Revenue =
SUM(retail_transactions_clean[net_revenue])

Total Profit =
SUM(retail_transactions_clean[profit])

Profit Margin % =
DIVIDE([Total Profit], [Total Revenue])

Total Orders =
DISTINCTCOUNT(retail_transactions_clean[order_id])

Total Customers =
DISTINCTCOUNT(retail_transactions_clean[customer_id])

Average Order Value =
DIVIDE([Total Revenue], [Total Orders])

Repeat Customers =
CALCULATE(
    DISTINCTCOUNT(retail_transactions_clean[customer_id]),
    retail_transactions_clean[repeat_customer_flag] = TRUE()
)

Repeat Customer Rate =
DIVIDE([Repeat Customers], [Total Customers])
```

## Page 1 - Executive Overview

### KPI Cards

- Total Revenue
- Total Profit
- Profit Margin %
- Total Orders
- Total Customers
- Average Order Value
- Repeat Customer Rate

### Visuals

- Line chart: Revenue and Profit by Month
- Clustered bar: Revenue vs Profit by Category
- Bar chart: Revenue by Region
- Table: Top 10 Customers by Revenue
- Slicers: Month, Region, Category, Customer Segment

### Business Use

This page gives leadership a fast view of overall business performance and highlights where growth or margin issues may exist.

## Page 2 - Customer & Retention

### Visuals

- Donut/bar: One-Time vs Repeat Customers
- Bar: Revenue by Customer Segment
- Scatter: Customer Order Count vs Lifetime Revenue
- Table: High-Value Customers
- Cohort matrix: Cohort Month by Months Since First Purchase

### Business Use

Helps marketing and sales teams identify valuable repeat customers, weak retention groups, and segments that deserve targeted retention efforts.

## Page 3 - Product & Profitability

### Visuals

- Bar: Top Products by Revenue
- Bar: Top Products by Profit
- Matrix: Category > Product with Revenue, Profit, Margin, Units
- Scatter: Discount % vs Profit
- Table: Low-Margin Products

### Business Use

Helps product, merchandising, and finance teams separate high-sales products from high-profit products and evaluate discounting decisions.

## Dashboard Story

A recruiter or stakeholder should be able to follow this sequence:

**Performance -> Customers -> Products -> Decisions**

That makes the dashboard more than a visualization exercise; it demonstrates business analysis and decision support.
