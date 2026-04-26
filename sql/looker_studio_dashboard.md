# Olist E-commerce Analytics Dashboard | Looker Studio

## Overview
This document describes the interactive dashboard built using **Google Looker Studio** (formerly Data Studio) for the Olist e-commerce analytics project. The dashboard connects to a BigQuery reporting view (`vw_sales_kpi`) and visualizes key business KPIs for e-commerce performance monitoring.

---

## Data Source

| Property | Value |
|----------|-------|
| Platform | Google Cloud BigQuery |
| Project ID | `silent-matter-465213-p9` |
| Dataset | `olist_raw` |
| Reporting View | `vw_sales_kpi` |
| Data Last Updated | April 26, 2026 |

---

## Dashboard KPIs

The dashboard tracks the following metrics from the `vw_sales_kpi` view:

### Sales Metrics
| KPI | Field Name | Description |
|-----|------------|-------------|
| Total Orders | `total_orders` | Count of all orders placed |
| Total Revenue | `total_revenue` | Sum of all item values |
| Total Customers | `total_customers` | Count of unique customers |
| Total Items Sold | `total_items_sold` | Count of all order items |

### Revenue Metrics
| KPI | Field Name | Description |
|-----|------------|-------------|
| Product Revenue | `total_product_revenue` | Revenue excluding freight |
| Total Freight | `total_freight` | Sum of all freight charges |

### Derived KPIs
| KPI | Field Name | Description |
|-----|------------|-------------|
| Average Order Value | `aov` | Avg revenue per order |
| Revenue Per Customer | `revenue_per_customer` | Avg revenue per customer |
| Freight Share % | `freight_share_pct` | Freight as % of total revenue |

### Time Dimensions
| Field | Description |
|-------|-------------|
| `year` | Year extracted from purchase date |
| `month` | Month extracted from purchase date |
| `year_month` | YYYY-MM format for trend analysis |

---

## Dashboard Structure

### Page 1: Executive Summary
- **KPI Scorecards**: Total Orders, Total Revenue, Total Customers, AOV
- **Revenue Trend Chart**: Monthly revenue trend with YoY comparison
- **Freight Share Gauge**: Visual indicator of freight cost percentage
- **Top Metrics Cards**: Revenue per customer, total items sold

### Page 2: Customer Analysis
- **Customer Trend**: Monthly customer acquisition
- **Revenue Per Customer**: Average revenue by month
- **Customer Distribution**: Geographic spread (when data available)

### Page 3: Order & Product Performance
- **Order Volume**: Monthly order count trend
- **Product Revenue**: Revenue breakdown by period
- **Freight Analysis**: Freight cost trends and share

---

## Data Model

```
olist_raw (BigQuery Dataset)
├── fact_orders          → Order-level facts
├── fact_order_items     → Order item details
├── dim_customers        → Customer dimensions
├── dim_products         → Product dimensions
└── vw_sales_kpi         → Final reporting view (Dashboard Source)
```

---

## Key Business Questions Answered

1. **How many total orders were placed?** → 98,666 orders tracked
2. **What is the total revenue generated?** → Visible on KPI scorecard
3. **What is the average order value (AOV)?** → Calculated from `aov` field
4. **How much revenue per customer?** → `revenue_per_customer` KPI
5. **What is the freight cost percentage?** → `freight_share_pct` KPI
6. **How do orders and revenue trend over time?** → Monthly trend charts using `year_month`

---

## Tools Used

- **Google Cloud Platform** (BigQuery) — Data storage & SQL processing
- **SQL** — Data cleaning, transformation, and KPI view creation
- **Looker Studio** — Interactive dashboard and visualization
- **GitHub Copilot** — Assisted in dashboard development and SQL queries
- **GitHub** — Version control and project documentation

---

## Dashboard Link

[View Live Dashboard](https://datastudio.google.com/reporting/e4290573-6241-4b2b-ba23-60d4414b6793/page/MOLwF)

---

## How to Recreate

1. Ensure BigQuery project `silent-matter-465213-p9` has the `olist_raw` dataset
2. Run `vw_sales_kpi.sql` to create the reporting view
3. Open Looker Studio and connect to the BigQuery data source
4. Select `vw_sales_kpi` as the data source
5. Add KPI scorecards, trend charts, and filters as described above
6. Publish and share the dashboard

---

## About the Author

**DEEPANRAJ A** | Data Analyst | SQL | BigQuery | Looker Studio | Power BI
- GitHub: [@deeepanbe](https://github.com/deeepanbe)
- LinkedIn: [DEEPANRAJ A](https://www.linkedin.com/in/deepanraj-data-analyst/)
- Email: deepanraj.a@outlook.com
