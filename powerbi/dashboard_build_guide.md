# Power BI Dashboard Build Guide

## Data Model
Load the cleaned retail dataset from `data/processed/retail_sales_clean.csv`.

Create a Calendar table:

```DAX
Calendar =
ADDCOLUMNS(
    CALENDAR(MIN(retail_sales[Order_Date]), MAX(retail_sales[Order_Date])),
    "Year", YEAR([Date]),
    "Month", FORMAT([Date], "MMM"),
    "Month Number", MONTH([Date]),
    "Year-Month", FORMAT([Date], "YYYY-MM"),
    "Quarter", "Q" & FORMAT([Date], "Q")
)
```

Create a one-to-many relationship:
`Calendar[Date] -> retail_sales[Order_Date]`.

## Page 1 — Executive Overview
Top KPI cards:
- Total Revenue
- Total Profit
- Profit Margin %
- Total Orders
- Total Customers
- Average Order Value

Visuals:
1. Line chart — Revenue by Year-Month
2. Clustered bar — Revenue and Profit by Category
3. Bar chart — Top 10 Products by Revenue
4. Map or bar chart — Revenue by Region
5. Donut chart — Revenue by Customer Segment
6. Slicers — Date, Region, Category, Segment

## Page 2 — Customer & Retention
KPI cards:
- Total Customers
- Repeat Customers
- Repeat Customer Rate %
- Revenue per Customer

Visuals:
1. Cohort retention matrix
2. Top customers by revenue
3. Revenue by customer segment
4. Orders per customer distribution
5. New vs repeat customer trend

## Page 3 — Product & Profitability
KPI cards:
- Total Profit
- Profit Margin %
- Highest Revenue Category
- Lowest Margin Category

Visuals:
1. Scatter plot — Revenue vs Profit by Product
2. Bar chart — Profit Margin % by Category
3. Matrix — Category > Product with Revenue, Profit, Margin
4. Trend — Monthly Profit
5. Bottom 10 products by Profit

## Formatting
Use `powerbi/theme.json` as the report theme.
Keep titles business-focused:
- "Where is revenue growing?"
- "Which products drive profit?"
- "Who are our highest-value customers?"
- "Are repeat customers growing?"

## Publish
After building:
1. Save as `Retail_Customer_Analytics_Capstone.pbix`
2. Publish to Power BI Service
3. Generate a public or portfolio-safe report link if appropriate
4. Add the dashboard link and screenshots to the README
5. Upload the real PBIX file to the repository under `powerbi/`
