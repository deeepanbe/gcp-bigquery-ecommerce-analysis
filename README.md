# E-Commerce Analytics Pipeline using Google BigQuery, SQL & Looker Studio

**Data Analyst | SQL | BigQuery | Python | Power BI | Looker Studio | GCP**

End-to-end analytics project on the Brazilian e-commerce dataset (Olist) using **SQL in Google Cloud BigQuery**, **Python** for ETL, **Power BI** for advanced dashboards, and **Looker Studio** for interactive reporting. This project demonstrates a complete data analytics workflow from raw data to business insights.

---

## 1. Business Problem

A Brazilian online marketplace needs answers to critical business questions:
- How are **revenue and orders trending** over time?
- Which **cities and states** drive the most sales?
- Which **product categories** generate the highest revenue?
- How do **actual delivery times** compare to estimates?
- Which **customer segments** deliver the most value?

As the Data Analyst, I built a complete analytics solution — from **data ingestion** to **dashboarding** — to turn raw e-commerce data into actionable business insights.

---

## 2. Dataset & Source

| Property | Value |
|----------|-------|
| Dataset | Olist E-Commerce Dataset |
| Source | [Kaggle - Brazilian E-commerce](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce) |
| Tables | orders, order_items, customers, products, payments |
| Total Orders | 98,666 |

---

## 3. Tech Stack

| Layer | Tools |
|-------|-------|
| **Storage & Compute** | Google Cloud BigQuery |
| **Data Querying** | SQL (BigQuery Dialect) |
| **ETL & Cleaning** | Python (Pandas) |
| **Visualization** | Power BI (DAX), Looker Studio |
| **Version Control** | GitHub |
| **AI Assistant** | GitHub Copilot, Microsoft Copilot |

---

## 4. Project Structure

```
gcp-bigquery-ecommerce-analysis/
├── README.md
├── sql/
│   ├── 01_schema_and_load.sql      → Table creation and data loading
│   ├── 02_kpi_views.sql            → KPI views for dashboard
│   ├── 03_trend_analysis.sql       → Trend and pattern analysis
│   ├── 04_customer_analysis.sql    → Customer segmentation
│   ├── 05_category_delivery.sql    → Category performance & delivery
│   └── vw_sales_kpi.sql            → Final reporting view for Looker Studio
├── sql/looker_studio_dashboard.md  → Dashboard documentation
├── python/etl_pipeline.py          → ETL pipeline
├── dashboard/ecommerce_dashboard.pbix → Power BI dashboard
└── assets/data_dictionary.md       → Data dictionary
```

---

## 5. Key Business Questions & KPIs

### Sales KPIs
| KPI | Field Name | Description |
|-----|------------|-------------|
| Total Orders | `total_orders` | Count of all orders |
| Total Revenue | `total_revenue` | Sum of all item values |
| Total Customers | `total_customers` | Unique customer count |
| Total Items Sold | `total_items_sold` | Count of order items |

### Revenue KPIs
| KPI | Field Name | Description |
|-----|------------|-------------|
| Product Revenue | `total_product_revenue` | Revenue excluding freight |
| Total Freight | `total_freight` | Total freight charges |
| AOV | `aov` | Average order value |
| Revenue Per Customer | `revenue_per_customer` | Avg revenue per customer |
| Freight Share % | `freight_share_pct` | Freight as % of revenue |

---

## 6. SQL Analysis (BigQuery)

### 6.1 KPI View
```sql
-- Core KPI aggregation with time dimensions
SELECT
  EXTRACT(YEAR FROM purchase_date) AS year,
  EXTRACT(MONTH FROM purchase_date) AS month,
  COUNT(DISTINCT order_id) AS total_orders,
  ROUND(SUM(total_item_value), 2) AS total_revenue,
  COUNT(DISTINCT customer_id) AS total_customers,
  ROUND(AVG(total_item_value), 2) AS aov
FROM `silent-matter-465213-p9.olist_raw.fact_orders`
GROUP BY year, month
ORDER BY year DESC, month DESC;
```

### 6.2 Trend Analysis
- Monthly revenue trend with YoY comparison
- Order volume patterns by day of week
- Customer acquisition trends

### 6.3 Customer Analysis
- Customer segmentation by spending
- Repeat customer rate
- Customer lifetime value (CLV)

### 6.4 Delivery Analysis
- On-time delivery percentage
- Average delivery days by region
- Delivery delay impact on ratings

### 6.5 Category Analysis
- Revenue by product category
- Top-selling categories
- Category-wise order distribution

---

## 7. Looker Studio Dashboard

The **Looker Studio** dashboard provides an interactive, business-ready view of e-commerce performance.

### Dashboard Features
- **KPI Scorecards**: Total Orders (98,666), Revenue, Customers, AOV
- **Trend Charts**: Monthly revenue and order trends
- **Freight Analysis**: Freight share percentage tracking
- **Time Filters**: Year, Month, Year-Month slicers

### Data Source
- BigQuery View: `vw_sales_kpi`
- Project: `silent-matter-465213-p9.olist_raw`
- [View Dashboard Documentation](sql/looker_studio_dashboard.md)

### Live Dashboard
[Open Looker Studio Dashboard](https://datastudio.google.com/reporting/e4290573-6241-4b2b-ba23-60d4414b6793/page/MOLwF)

---

## 8. Key Insights

- Revenue concentrated in **Sao Paulo** and **Rio de Janeiro**
- **Electronics & Gadgets** dominate sales
- Delivery performance varies significantly by region
- Top 20% customers drive disproportionate revenue
- Average freight share is a key cost factor for pricing decisions

---

## 9. How to Reproduce

1. **Set up BigQuery project** with the dataset `olist_raw`
2. **Load raw data** using the `01_schema_and_load.sql` script
3. **Run SQL queries** from `sql/` folder in order (01 through 05)
4. **Create reporting view** by running `vw_sales_kpi.sql`
5. **Connect Looker Studio** to BigQuery and select `vw_sales_kpi`
6. **Connect Power BI** to BigQuery views for advanced dashboards
7. **Run Python ETL** pipeline for additional data processing

---

## 10. Workflow Summary

```
Raw Olist Data
    ↓
BigQuery (GCP) - Data Loading
    ↓
SQL - Data Cleaning & Transformation
    ↓
KPI Views & Reporting Layer
    ↓
vw_sales_kpi (Final Reporting View)
    ↓
Looker Studio Dashboard + Power BI
    ↓
Business Insights & Decision Support
```

---

## 11. About the Author

**DEEPANRAJ A** | Data Analyst | SQL | BigQuery | Looker Studio | Power BI | Python
- Location: Coimbatore, Tamil Nadu, India
- GitHub: [@deeepanbe](https://github.com/deeepanbe)
- LinkedIn: [DEEPANRAJ A](https://www.linkedin.com/in/deepanraj-data-analyst/)
- Email: deepanraj.a@outlook.com
- Open to full-time Data Analyst roles in India

---

## 12. License

MIT License - feel free to use and adapt for your projects.
