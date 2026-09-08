# Retail Customer Analytics Capstone

## End-to-End Sales, Retention & Profitability Analysis

This capstone project solves a practical retail analytics problem using **Python, SQL, and Power BI**. The goal is to understand what drives revenue, repeat purchases, customer retention, and product profitability, then translate those findings into decisions a business team can act on.

## Business Problem

Retail teams often have large volumes of transaction data but limited visibility into which customers, products, categories, and sales periods are actually driving profitable growth.

This project answers four business questions:

1. Which customers and segments generate the most revenue?
2. Which products and categories drive sales volume versus profitability?
3. What does repeat-purchase and retention behavior look like over time?
4. Where should the business focus marketing, inventory, and customer-retention efforts?

## Project Workflow

`Raw Data -> Python Cleaning & EDA -> SQL Analysis -> Power BI Data Model -> Dashboard -> Business Recommendations`

## Tools Used

- **Python / Pandas** - data cleaning, transformation, exploratory analysis, feature engineering
- **SQL** - customer, revenue, cohort, product, and profitability analysis
- **Power BI** - interactive dashboard, KPI tracking, DAX measures, executive reporting
- **Excel/CSV** - source and validation files
- **Git/GitHub** - version control and project documentation

## Repository Structure

```text
retail-customer-analytics-capstone/
│
├── README.md
├── data/
│   └── retail_transactions_sample.csv
├── python/
│   └── retail_customer_analysis.py
├── sql/
│   ├── 01_create_tables.sql
│   ├── 02_business_analysis.sql
│   └── 03_customer_retention.sql
├── powerbi/
│   └── dashboard_spec.md
└── docs/
    └── business_findings.md
```

## Dataset

The included dataset is a **synthetic retail transaction dataset** created for portfolio demonstration. It contains order-level activity across customers, products, categories, regions, quantities, prices, discounts, and costs.

Main fields:

- order_id
- order_date
- customer_id
- customer_segment
- region
- product_id
- product_name
- category
- quantity
- unit_price
- unit_cost
- discount_pct

The Python workflow derives additional metrics such as:

- gross_revenue
- net_revenue
- total_cost
- profit
- profit_margin
- customer_order_count
- first_purchase_date
- repeat_customer_flag

## Python Analysis

The Python script performs the end-to-end preparation layer:

- Loads raw transaction data
- Checks missing values and duplicates
- Standardizes data types
- Calculates revenue, cost, profit, and margin
- Creates monthly reporting fields
- Builds customer-level summaries
- Identifies repeat customers
- Produces category and regional performance summaries
- Exports clean analytical datasets for SQL and Power BI

Run:

```bash
python python/retail_customer_analysis.py
```

## SQL Analysis

The SQL layer answers business questions through reusable queries.

### Revenue & Profitability
- Monthly revenue and profit trends
- Top products by revenue
- Top products by profit
- Category margin analysis
- Regional performance

### Customer Analytics
- Top customers by lifetime revenue
- Average order value
- Purchase frequency
- Repeat versus one-time customers
- Revenue concentration among top customers

### Retention
- First-purchase month cohorts
- Repeat purchase rates
- Customer retention by cohort
- Months between purchases

## Power BI Dashboard

The dashboard is designed as a three-page executive report.

### Page 1 - Executive Overview
KPIs:
- Total Revenue
- Total Profit
- Profit Margin
- Orders
- Customers
- Average Order Value
- Repeat Customer Rate

Visuals:
- Monthly Revenue & Profit Trend
- Revenue by Category
- Profit by Category
- Revenue by Region
- Top 10 Customers

### Page 2 - Customer & Retention Analysis
- New vs Repeat Customers
- Customer Segment Performance
- Customer Lifetime Revenue
- Purchase Frequency
- Retention / Cohort Matrix

### Page 3 - Product & Profitability Analysis
- Top Products by Revenue
- Top Products by Profit
- Low-Margin Products
- Discount vs Profit Relationship
- Category/Product Drilldown

See [`powerbi/dashboard_spec.md`](powerbi/dashboard_spec.md) for measures and dashboard design details.

## Example Business Insights

The analysis is structured to surface findings such as:

- A relatively small set of repeat customers may account for a disproportionate share of revenue.
- High-revenue products are not always the highest-profit products.
- Heavy discounting can increase sales volume while compressing profit margin.
- Some categories may generate strong revenue but require margin or pricing review.
- Cohort analysis can show whether newer customer groups are returning at the same rate as earlier cohorts.

## Business Recommendations

Based on the analysis framework, the business can:

1. Prioritize high-value repeat customers with targeted retention campaigns.
2. Separate revenue KPIs from profitability KPIs when evaluating product performance.
3. Review discount strategies for products with high sales but weak margins.
4. Use customer cohort trends to measure whether retention initiatives are improving.
5. Focus inventory and marketing resources on products that combine strong demand with healthy profitability.

## Skills Demonstrated

- End-to-end analytics problem solving
- Python data wrangling with Pandas
- SQL joins, aggregations, window functions, CTEs, cohort logic
- KPI development
- Customer segmentation
- Retention analysis
- Revenue and profitability analysis
- Data modeling for Power BI
- DAX measure design
- Dashboard storytelling
- Translating analysis into business recommendations

## Resume-Ready Project Description

**Retail Sales & Customer Retention Analytics | Python, SQL, Power BI**

Built an end-to-end retail analytics solution using Python/Pandas and SQL to clean transaction data, analyze customer retention, revenue, and product profitability, and design a Power BI executive dashboard with KPIs and cohort analysis. Translated findings into recommendations for customer retention, pricing, marketing spend, and inventory decisions.

## Author

**Lokesh Kancharla**  
Data Analyst | SQL | Power BI | Python | Financial & Business Analytics
