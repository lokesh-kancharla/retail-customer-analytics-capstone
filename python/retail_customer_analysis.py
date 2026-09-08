import pandas as pd
from pathlib import Path

BASE_DIR = Path(__file__).resolve().parents[1]
DATA_PATH = BASE_DIR / "data" / "retail_transactions_sample.csv"
OUTPUT_DIR = BASE_DIR / "output"
OUTPUT_DIR.mkdir(exist_ok=True)

# Load data
sales = pd.read_csv(DATA_PATH, parse_dates=["order_date"])

# Data quality checks
sales = sales.drop_duplicates().copy()
required_cols = [
    "order_id", "order_date", "customer_id", "customer_segment", "region",
    "product_id", "product_name", "category", "quantity", "unit_price",
    "unit_cost", "discount_pct"
]
missing_required = sales[required_cols].isna().sum()
if missing_required.sum() > 0:
    raise ValueError(f"Missing values found in required fields:\n{missing_required[missing_required > 0]}")

# Feature engineering
sales["gross_revenue"] = sales["quantity"] * sales["unit_price"]
sales["discount_amount"] = sales["gross_revenue"] * sales["discount_pct"]
sales["net_revenue"] = sales["gross_revenue"] - sales["discount_amount"]
sales["total_cost"] = sales["quantity"] * sales["unit_cost"]
sales["profit"] = sales["net_revenue"] - sales["total_cost"]
sales["profit_margin"] = sales["profit"] / sales["net_revenue"]
sales["order_month"] = sales["order_date"].dt.to_period("M").astype(str)

# Customer-level analysis
customer_summary = (
    sales.groupby("customer_id")
    .agg(
        first_purchase_date=("order_date", "min"),
        last_purchase_date=("order_date", "max"),
        customer_order_count=("order_id", "nunique"),
        lifetime_revenue=("net_revenue", "sum"),
        lifetime_profit=("profit", "sum"),
    )
    .reset_index()
)
customer_summary["repeat_customer_flag"] = customer_summary["customer_order_count"].gt(1)

sales = sales.merge(
    customer_summary[["customer_id", "customer_order_count", "first_purchase_date", "repeat_customer_flag"]],
    on="customer_id",
    how="left",
)

# Monthly performance
monthly_summary = (
    sales.groupby("order_month")
    .agg(
        revenue=("net_revenue", "sum"),
        profit=("profit", "sum"),
        orders=("order_id", "nunique"),
        customers=("customer_id", "nunique"),
    )
    .reset_index()
)
monthly_summary["profit_margin"] = monthly_summary["profit"] / monthly_summary["revenue"]
monthly_summary["average_order_value"] = monthly_summary["revenue"] / monthly_summary["orders"]

# Product/category performance
category_summary = (
    sales.groupby("category")
    .agg(
        revenue=("net_revenue", "sum"),
        profit=("profit", "sum"),
        units_sold=("quantity", "sum"),
        orders=("order_id", "nunique"),
    )
    .reset_index()
)
category_summary["profit_margin"] = category_summary["profit"] / category_summary["revenue"]

regional_summary = (
    sales.groupby("region")
    .agg(
        revenue=("net_revenue", "sum"),
        profit=("profit", "sum"),
        orders=("order_id", "nunique"),
        customers=("customer_id", "nunique"),
    )
    .reset_index()
)

# Export analytics-ready files
sales.to_csv(OUTPUT_DIR / "retail_transactions_clean.csv", index=False)
customer_summary.to_csv(OUTPUT_DIR / "customer_summary.csv", index=False)
monthly_summary.to_csv(OUTPUT_DIR / "monthly_summary.csv", index=False)
category_summary.to_csv(OUTPUT_DIR / "category_summary.csv", index=False)
regional_summary.to_csv(OUTPUT_DIR / "regional_summary.csv", index=False)

# Console summary for quick validation
print("Rows:", len(sales))
print("Orders:", sales["order_id"].nunique())
print("Customers:", sales["customer_id"].nunique())
print("Revenue:", round(sales["net_revenue"].sum(), 2))
print("Profit:", round(sales["profit"].sum(), 2))
print("Repeat customer rate:", round(customer_summary["repeat_customer_flag"].mean(), 4))
