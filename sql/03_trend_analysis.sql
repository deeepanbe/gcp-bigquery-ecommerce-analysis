-- ============================================================================
-- 03_trend_analysis.sql
-- E-Commerce Analytics Pipeline | Google BigQuery
-- Purpose: Trend analysis queries for revenue, orders, and customer behavior
-- ============================================================================

-- Query 1: Week-over-Week Revenue Growth
SELECT
  DATE_TRUNC(o.order_purchase_timestamp, WEEK) AS week_start,
  COUNT(DISTINCT o.order_id) AS orders,
  ROUND(SUM(oi.price + oi.freight_value), 2) AS revenue,
  LAG(COUNT(DISTINCT o.order_id)) OVER (ORDER BY DATE_TRUNC(o.order_purchase_timestamp, WEEK)) AS prev_orders,
  LAG(ROUND(SUM(oi.price + oi.freight_value), 2)) OVER (ORDER BY DATE_TRUNC(o.order_purchase_timestamp, WEEK)) AS prev_revenue
FROM olist_ecommerce.orders o
JOIN olist_ecommerce.order_items oi ON o.order_id = oi.order_id
GROUP BY week_start
ORDER BY week_start;

-- Query 2: Day of Week Order Pattern
SELECT
  FORMAT_DATE('%A', o.order_purchase_timestamp) AS day_of_week,
  COUNT(DISTINCT o.order_id) AS total_orders,
  ROUND(SUM(oi.price + oi.freight_value), 2) AS total_revenue
FROM olist_ecommerce.orders o
JOIN olist_ecommerce.order_items oi ON o.order_id = oi.order_id
GROUP BY day_of_week
ORDER BY total_orders DESC;

-- Query 3: Hour of Day Purchase Pattern
SELECT
  EXTRACT(HOUR FROM o.order_purchase_timestamp) AS hour_of_day,
  COUNT(DISTINCT o.order_id) AS orders,
  ROUND(SUM(oi.price + oi.freight_value), 2) AS revenue
FROM olist_ecommerce.orders o
JOIN olist_ecommerce.order_items oi ON o.order_id = oi.order_id
GROUP BY hour_of_day
ORDER BY hour_of_day;

-- Query 4: New vs Returning Customers
SELECT
  CASE
    WHEN customer_order_count = 1 THEN 'New Customer'
    ELSE 'Returning Customer'
  END AS customer_type,
  COUNT(DISTINCT customer_id) AS customer_count,
  SUM(customer_order_count) AS total_orders
FROM (
  SELECT customer_id, COUNT(order_id) AS customer_order_count
  FROM olist_ecommerce.orders
  GROUP BY customer_id
)
GROUP BY customer_type;

-- Query 5: Average Days to Purchase (Time Between First and Last Order)
SELECT
  customer_id,
  MIN(order_purchase_timestamp) AS first_order,
  MAX(order_purchase_timestamp) AS last_order,
  COUNT(order_id) AS total_orders,
  DATE_DIFF(MAX(order_purchase_timestamp), MIN(order_purchase_timestamp), DAY) AS days_active
FROM olist_ecommerce.orders
GROUP BY customer_id
ORDER BY total_orders DESC;
