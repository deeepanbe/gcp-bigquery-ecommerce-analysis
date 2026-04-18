# gcp-bigquery-ecommerce-analysis

E-Commerce Analytics using Google Cloud BigQuery - SQL analysis on the Brazilian E-Commerce Public Dataset by Olist.

---

## Project Overview

This project demonstrates end-to-end data analytics workflow using Google Cloud BigQuery. It involves loading e-commerce data into BigQuery, designing a star-schema data model, and performing SQL analysis to derive business insights.

---

## Tools and Technologies

- **Google Cloud BigQuery** - Cloud Data Warehouse
- **SQL (BigQuery Dialect)** - Data querying and analysis
- **Kaggle** - Olist E-Commerce Dataset
- **GitHub** - Version control and project documentation

---

## Dataset

The Brazilian E-Commerce Public Dataset by Olist contains real e-commerce transactions from Brazil. It includes:

| Table | Description | Records |
|-------|-------------|--------|
| `customers` | Customer demographics (city, state) | 10 |
| `products` | Product catalog with categories and prices | 10 |
| `orders` | Order details with shipping timeline | 15 |
| `order_items` | Items per order with quantities | 20 |
| `payments` | Payment methods and amounts | 15 |

---

## Key Analysis Queries

### 1. Total Orders and Revenue

```sql
SELECT
  COUNT(DISTINCT o.order_id) as total_orders,
  ROUND(SUM(p.amount), 2) as total_revenue,
  ROUND(AVG(p.amount), 2) as avg_order_value
FROM `olist_ecommerce.orders` o
JOIN `olist_ecommerce.payments` p ON o.order_id = p.order_id;
```

**Results:**
| total_orders | total_revenue | avg_order_value |
|-------------|--------------|-----------------|
| 15 | 1323.63 | 88.24 |

### 2. Monthly Order Trends

```sql
SELECT
  FORMAT_DATE('%Y-%m', PARSE_DATE('%Y-%m-%d', order_date)) as order_month,
  COUNT(DISTINCT order_id) as orders,
  COUNT(DISTINCT customer_id) as unique_customers
FROM `olist_ecommerce.orders`
GROUP BY 1
ORDER BY 1;
```

### 3. Top Customers by Spending

```sql
SELECT
  c.customer_id,
  c.customer_city as city,
  c.customer_state as state,
  COUNT(DISTINCT o.order_id) as total_orders,
  ROUND(SUM(p.amount), 2) as total_spending
FROM `olist_ecommerce.customers` c
JOIN `olist_ecommerce.orders` o ON c.customer_id = o.customer_id
JOIN `olist_ecommerce.payments` p ON o.order_id = p.order_id
GROUP BY 1, 2, 3
ORDER BY total_spending DESC
LIMIT 5;
```

---

## Business Insights

- **Total Revenue:** $1,323.63 from 15 orders
- **Average Order Value:** $88.24
- **Top Performing Month:** January 2024 with highest order volume
- **Best Customers:** CUST001 (Sao Paulo, SP) and CUST002 (Rio de Janeiro, RJ) lead in spending
- **Popular Categories:** Electronics & Gadgets dominates product sales

---

## How to Reproduce

1. Create a BigQuery project on Google Cloud Console
2. Create dataset: `olist_ecommerce`
3. Run the SQL scripts to create tables and load data
4. Execute analysis queries

---

## Author

**DEEPANRAJ A**
Data Analyst | SQL | BigQuery | Power BI
GitHub: [@deeepanbe](https://github.com/deeepanbe)
LinkedIn: [DEEPANRAJ A](https://linkedin.com/in/deepanraj-data-analyst)

---

## License

MIT License
