# E-Commerce Analytics Pipeline using Google BigQuery & Power BI

**Data Analyst | SQL | BigQuery | Python | Power BI**

End-to-end analytics project on the Brazilian e-commerce dataset (Olist) using **SQL in Google Cloud BigQuery** and **Power BI** to uncover revenue trends, customer behavior, product performance, and delivery insights.

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

| Table | Description |
|---|---|
| `orders` | Order status, purchase date, delivery dates |
| `order_items` | Products, prices, freight values |
| `customers` | Customer IDs, city, state |
| `products` | Product categories and attributes |
| `payments` | Payment methods and amounts |

**Source:** [Olist E-Commerce Dataset on Kaggle](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)

---

## 3. Tech Stack

| Layer | Tools |
|---|---|
| **Storage & Compute** | Google Cloud BigQuery |
| **Data Querying** | SQL (BigQuery Dialect) |
| **ETL & Cleaning** | Python (Pandas) |
| **Visualization** | Power BI (DAX, Interactive Dashboards) |
| **Version Control** | GitHub |
| **Cloud Platform** | Google Cloud Console |

---

## 4. Project Structure

```
gcp-bigquery-ecommerce-analysis/
├── README.md                    # This file
├── sql/
│   ├── 01_schema_and_load.sql   # Table creation & data loading
│   ├── 02_kpi_views.sql         # KPI views for dashboard
│   ├── 03_trend_analysis.sql    # Monthly trends & patterns
│   ├── 04_customer_analysis.sql # Customer segmentation
│   └── 05_category_delivery.sql # Category & delivery analysis
├── python/
│   └── etl_pipeline.py          # Data cleaning & transformation
├── dashboard/
│   ├── ecommerce_dashboard.pbix # Power BI report file
│   └── screenshots/
│       ├── kpi_overview.png
│       ├── sales_trend.png
│       └── geography_analysis.png
└── assets/
    └── data_dictionary.md       # Column-level documentation
```

---

## 5. Key Business Questions & KPIs

### KPIs Tracked
- **Total Orders & Revenue**
- **Average Order Value (AOV)**
- **Unique Customers**
- **On-Time Delivery %**
- **Average Delivery Days**

### Business Questions
1. What is the month-over-month revenue and order trend?
2. Which states and cities contribute the most revenue?
3. Which product categories drive the highest sales?
4. What percentage of orders are delivered on time?
5. Who are the top-spending customers and where are they located?

---

## 6. SQL Analysis (BigQuery)

### 6.1 KPI View — Revenue, Orders, Customers

```sql
SELECT
  COUNT(DISTINCT o.order_id) AS total_orders,
  ROUND(SUM(p.amount), 2) AS total_revenue,
  ROUND(AVG(p.amount), 2) AS avg_order_value,
  COUNT(DISTINCT o.customer_id) AS unique_customers
FROM `olist_ecommerce.orders` o
JOIN `olist_ecommerce.payments` p
  ON o.order_id = p.order_id;
```

| total_orders | total_revenue | avg_order_value | unique_customers |
|---|---|---|---|
| 15 | 1323.63 | 88.24 | 12 |

### 6.2 Monthly Order Trends

```sql
SELECT
  FORMAT_DATE('%Y-%m', PARSE_DATE('%Y-%m-%d', order_date)) AS order_month,
  COUNT(DISTINCT order_id) AS orders,
  COUNT(DISTINCT customer_id) AS unique_customers
FROM `olist_ecommerce.orders`
GROUP BY order_month
ORDER BY order_month;
```

### 6.3 Top Customers by Spending

```sql
SELECT
  c.customer_id,
  c.customer_city AS city,
  c.customer_state AS state,
  COUNT(DISTINCT o.order_id) AS total_orders,
  ROUND(SUM(p.amount), 2) AS total_spending
FROM `olist_ecommerce.customers` c
JOIN `olist_ecommerce.orders` o ON c.customer_id = o.customer_id
JOIN `olist_ecommerce.payments` p ON o.order_id = p.order_id
GROUP BY c.customer_id, c.customer_city, c.customer_state
ORDER BY total_spending DESC
LIMIT 5;
```

### 6.4 Delivery Performance — On-Time vs Late

```sql
SELECT
  COUNT(*) AS total_delivered,
  SUM(CASE WHEN order_delivered_customer_date <= order_estimated_delivery_date
           THEN 1 ELSE 0 END) AS on_time_deliveries,
  ROUND(100.0 * SUM(CASE WHEN order_delivered_customer_date <= order_estimated_delivery_date
           THEN 1 ELSE 0 END) / COUNT(*), 2) AS on_time_percentage
FROM `olist_ecommerce.orders`
WHERE order_status = 'delivered';
```

### 6.5 Revenue by Product Category

```sql
SELECT
  pr.product_category_name,
  COUNT(DISTINCT oi.order_id) AS total_orders,
  ROUND(SUM(oi.price), 2) AS total_revenue
FROM `olist_ecommerce.order_items` oi
JOIN `olist_ecommerce.products` pr ON oi.product_id = pr.product_id
GROUP BY pr.product_category_name
ORDER BY total_revenue DESC;
```

---

## 7. Power BI Dashboard

I built a one-page **E-Commerce Analytics Dashboard** connected to BigQuery views, featuring:

| Section | Visuals |
|---|---|
| **Executive KPIs** | Total Revenue, Total Orders, AOV, Unique Customers, On-Time Delivery % |
| **Sales Trend** | Monthly revenue & orders line chart |
| **Geography** | Map & bar chart of state-wise and city-wise revenue |
| **Products** | Top categories by revenue and order volume |
| **Delivery** | On-time vs late delivery donut chart, avg delay days |

> *Dashboard screenshots will be added to `dashboard/screenshots/` once published.*

---

## 8. Key Insights

- **Revenue is concentrated** in a few major states (Sao Paulo, Rio de Janeiro), indicating opportunities to expand into under-served regions.
- **Electronics & Gadgets** dominate both order volume and revenue, suggesting focus areas for promotions and inventory planning.
- **Delivery performance varies significantly** by region — a subset of orders shows notable delays, flagging a logistics optimization opportunity.
- **Top 20% of customers** contribute a disproportionate share of revenue, presenting a clear case for loyalty programs and retention campaigns.

---

## 9. How to Reproduce

1. **Set up BigQuery:** Create a project on [Google Cloud Console](https://console.cloud.google.com)
2. **Create dataset:** `CREATE SCHEMA olist_ecommerce;`
3. **Load data:** Run `sql/01_schema_and_load.sql` to create tables
4. **Run analysis:** Execute SQL files in order (02 through 05)
5. **Build dashboard:** Connect Power BI to BigQuery views and design visuals per Section 7

---

## 10. About Me

**Deepanraj A** — Data Analyst based in Chennai, India.

I combine **SQL, Python, Power BI, and cloud analytics** to turn raw data into dashboards and business decisions. With 4+ years of experience in manufacturing and quality analytics, I bring a strong operations mindset to data-driven problem solving.

- **GitHub:** [@deeepanbe](https://github.com/deeepanbe)
- **LinkedIn:** [Deepanraj A](https://linkedin.com/in/deepanraj-data-analyst)
- **Email:** deepanraj.a@outlook.com

---

*License: MIT*
