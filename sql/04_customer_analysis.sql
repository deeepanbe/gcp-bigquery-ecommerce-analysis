-- ============================================================================
-- 04_customer_analysis.sql
-- E-Commerce Analytics Pipeline | Google BigQuery
-- Purpose: Customer segmentation, geography, and spending analysis
-- ============================================================================

-- Query 1: Top Customers by Spending
SELECT
  c.customer_id,
  c.customer_city,
  c.customer_state,
  COUNT(DISTINCT o.order_id) AS total_orders,
  ROUND(SUM(oi.price + oi.freight_value), 2) AS total_spending
FROM olist_ecommerce.customers c
JOIN olist_ecommerce.orders o ON c.customer_id = o.customer_id
JOIN olist_ecommerce.order_items oi ON o.order_id = oi.order_id
GROUP BY c.customer_id, c.customer_city, c.customer_state
ORDER BY total_spending DESC
LIMIT 10;

-- Query 2: Revenue by State
SELECT
  c.customer_state AS state,
  COUNT(DISTINCT o.order_id) AS total_orders,
  COUNT(DISTINCT c.customer_id) AS unique_customers,
  ROUND(SUM(oi.price + oi.freight_value), 2) AS total_revenue
FROM olist_ecommerce.customers c
JOIN olist_ecommerce.orders o ON c.customer_id = o.customer_id
JOIN olist_ecommerce.order_items oi ON o.order_id = oi.order_id
GROUP BY state
ORDER BY total_revenue DESC;

-- Query 3: Revenue by City
SELECT
  c.customer_city AS city,
  c.customer_state AS state,
  COUNT(DISTINCT o.order_id) AS total_orders,
  ROUND(SUM(oi.price + oi.freight_value), 2) AS total_revenue
FROM olist_ecommerce.customers c
JOIN olist_ecommerce.orders o ON c.customer_id = o.customer_id
JOIN olist_ecommerce.order_items oi ON o.order_id = oi.order_id
GROUP BY city, state
ORDER BY total_revenue DESC
LIMIT 20;

-- Query 4: Customer Lifetime Value (CLV) Estimation
SELECT
  c.customer_id,
  c.customer_city,
  c.customer_state,
  COUNT(o.order_id) AS order_count,
  ROUND(AVG(oi.price + oi.freight_value), 2) AS avg_order_value,
  ROUND(SUM(oi.price + oi.freight_value), 2) AS total_lifetime_value,
  MIN(o.order_purchase_timestamp) AS first_order_date,
  MAX(o.order_purchase_timestamp) AS last_order_date
FROM olist_ecommerce.customers c
JOIN olist_ecommerce.orders o ON c.customer_id = o.customer_id
JOIN olist_ecommerce.order_items oi ON o.order_id = oi.order_id
GROUP BY c.customer_id, c.customer_city, c.customer_state
ORDER BY total_lifetime_value DESC;

-- Query 5: Customers by Order Frequency
SELECT
  order_frequency,
  COUNT(DISTINCT customer_id) AS customer_count,
  ROUND(AVG(total_spent), 2) AS avg_spent
FROM (
  SELECT
    customer_id,
    COUNT(order_id) AS order_frequency,
    SUM(oi.price + oi.freight_value) AS total_spent
  FROM olist_ecommerce.orders o
  JOIN olist_ecommerce.order_items oi ON o.order_id = oi.order_id
  GROUP BY customer_id
)
GROUP BY order_frequency
ORDER BY order_frequency;
