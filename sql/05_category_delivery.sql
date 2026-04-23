-- ============================================================================
-- 05_category_delivery.sql
-- E-Commerce Analytics Pipeline | Google BigQuery
-- Purpose: Product category performance and delivery analysis
-- ============================================================================

-- Query 1: Revenue by Product Category
SELECT
  p.product_category_name AS category,
  COUNT(DISTINCT oi.order_id) AS total_orders,
  COUNT(DISTINCT p.product_id) AS unique_products,
  ROUND(SUM(oi.price), 2) AS total_revenue,
  ROUND(AVG(oi.price), 2) AS avg_price
FROM olist_ecommerce.products p
JOIN olist_ecommerce.order_items oi ON p.product_id = oi.product_id
GROUP BY category
ORDER BY total_revenue DESC;

-- Query 2: On-Time vs Late Delivery
SELECT
  COUNT(*) AS total_delivered,
  SUM(CASE WHEN o.order_delivered_customer_date <= o.order_estimated_delivery_date
           THEN 1 ELSE 0 END) AS on_time,
  SUM(CASE WHEN o.order_delivered_customer_date > o.order_estimated_delivery_date
           THEN 1 ELSE 0 END) AS late,
  ROUND(100.0 * SUM(CASE WHEN o.order_delivered_customer_date <= o.order_estimated_delivery_date
           THEN 1 ELSE 0 END) / COUNT(*), 2) AS on_time_pct,
  ROUND(100.0 * SUM(CASE WHEN o.order_delivered_customer_date > o.order_estimated_delivery_date
           THEN 1 ELSE 0 END) / COUNT(*), 2) AS late_pct
FROM olist_ecommerce.orders o
WHERE o.order_status = 'delivered';

-- Query 3: Average Delivery Days
SELECT
  AVG(DATE_DIFF(o.order_delivered_customer_date, o.order_purchase_timestamp, DAY)) AS avg_delivery_days,
  MIN(DATE_DIFF(o.order_delivered_customer_date, o.order_purchase_timestamp, DAY)) AS min_delivery_days,
  MAX(DATE_DIFF(o.order_delivered_customer_date, o.order_purchase_timestamp, DAY)) AS max_delivery_days
FROM olist_ecommerce.orders o
WHERE o.order_status = 'delivered'
  AND o.order_delivered_customer_date IS NOT NULL;

-- Query 4: Delivery Delay by State
SELECT
  c.customer_state AS state,
  COUNT(o.order_id) AS total_orders,
  ROUND(AVG(DATE_DIFF(o.order_delivered_customer_date, o.order_estimated_delivery_date, DAY)), 2) AS avg_delay_days
FROM olist_ecommerce.orders o
JOIN olist_ecommerce.customers c ON o.customer_id = c.customer_id
WHERE o.order_status = 'delivered'
  AND o.order_delivered_customer_date IS NOT NULL
GROUP BY state
ORDER BY avg_delay_days DESC;

-- Query 5: Category vs Delivery Performance
SELECT
  p.product_category_name AS category,
  COUNT(DISTINCT oi.order_id) AS total_orders,
  ROUND(SUM(oi.price + oi.freight_value), 2) AS total_revenue,
  ROUND(AVG(DATE_DIFF(o.order_delivered_customer_date, o.order_estimated_delivery_date, DAY)), 2) AS avg_delay
FROM olist_ecommerce.order_items oi
JOIN olist_ecommerce.products p ON oi.product_id = p.product_id
JOIN olist_ecommerce.orders o ON oi.order_id = o.order_id
WHERE o.order_status = 'delivered'
  AND o.order_delivered_customer_date IS NOT NULL
GROUP BY category
ORDER BY total_revenue DESC;
