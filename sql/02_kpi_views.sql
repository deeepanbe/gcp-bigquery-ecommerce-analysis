-- ============================================================================
-- 02_kpi_views.sql
-- E-Commerce Analytics Pipeline | Google BigQuery
-- Purpose: Create KPI views for Power BI dashboard
-- ============================================================================

-- View 1: Executive KPI Summary
CREATE OR REPLACE VIEW olist_ecommerce.vw_executive_kpi AS
SELECT
  COUNT(DISTINCT o.order_id) AS total_orders,
  ROUND(SUM(oi.price + oi.freight_value), 2) AS total_revenue,
  ROUND(AVG(oi.price + oi.freight_value), 2) AS avg_order_value,
  COUNT(DISTINCT o.customer_id) AS unique_customers
FROM olist_ecommerce.orders o
JOIN olist_ecommerce.order_items oi ON o.order_id = oi.order_id;

-- View 2: Monthly Revenue & Order Trend
CREATE OR REPLACE VIEW olist_ecommerce.vw_monthly_trend AS
SELECT
  DATE_TRUNC(o.order_purchase_timestamp, MONTH) AS order_month,
  COUNT(DISTINCT o.order_id) AS total_orders,
  COUNT(DISTINCT o.customer_id) AS unique_customers,
  ROUND(SUM(oi.price + oi.freight_value), 2) AS total_revenue,
  ROUND(AVG(oi.price + oi.freight_value), 2) AS avg_order_value
FROM olist_ecommerce.orders o
JOIN olist_ecommerce.order_items oi ON o.order_id = oi.order_id
WHERE o.order_status IN ('delivered', 'shipped')
GROUP BY order_month
ORDER BY order_month;

-- View 3: Payment Type Distribution
CREATE OR REPLACE VIEW olist_ecommerce.vw_payment_distribution AS
SELECT
  p.payment_type,
  COUNT(DISTINCT p.order_id) AS total_orders,
  ROUND(SUM(p.payment_value), 2) AS total_amount,
  ROUND(100.0 * COUNT(DISTINCT p.order_id) /
    (SELECT COUNT(DISTINCT order_id) FROM olist_ecommerce.payments), 2) AS pct_orders
FROM olist_ecommerce.payments p
GROUP BY p.payment_type
ORDER BY total_amount DESC;

-- View 4: Order Status Summary
CREATE OR REPLACE VIEW olist_ecommerce.vw_order_status AS
SELECT
  order_status,
  COUNT(order_id) AS total_orders,
  ROUND(100.0 * COUNT(order_id) /
    (SELECT COUNT(order_id) FROM olist_ecommerce.orders), 2) AS pct
FROM olist_ecommerce.orders
GROUP BY order_status
ORDER BY total_orders DESC;
