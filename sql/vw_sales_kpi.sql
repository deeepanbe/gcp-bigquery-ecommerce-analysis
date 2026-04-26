-- ===================================================================
-- vw_sales_kpi.sql
-- Olist E-commerce Analytics Dashboard - Reporting View
-- Project: GCP BigQuery E-commerce Analysis
-- Author: DEEPANRAJ A (@deeepanbe)
-- Description: Final reporting view for Looker Studio dashboard
--              Aggregates all KPIs from Olist e-commerce dataset
-- ===================================================================

CREATE OR REPLACE VIEW `silent-matter-465213-p9.olist_raw.vw_sales_kpi` AS
SELECT
  -- Date Dimensions
  EXTRACT(YEAR FROM fo.purchase_date) AS year,
  EXTRACT(MONTH FROM fo.purchase_date) AS month,
  FORMAT_DATE('%Y-%m', fo.purchase_date) AS year_month,

  -- Sales KPIs
  COUNT(DISTINCT fo.order_id) AS total_orders,
  COUNT(DISTINCT fo.customer_id) AS total_customers,
  COUNT(foi.order_item_id) AS total_items_sold,

  -- Revenue Metrics
  ROUND(SUM(foi.total_item_value), 2) AS total_revenue,
  ROUND(SUM(foi.total_item_value) - SUM(foi.total_freight_value), 2) AS total_product_revenue,
  ROUND(SUM(foi.total_freight_value), 2) AS total_freight,

  -- Derived KPIs
  ROUND(AVG(foi.total_item_value), 2) AS aov,
  ROUND(SUM(foi.total_item_value) / COUNT(DISTINCT fo.customer_id), 2) AS revenue_per_customer,
  ROUND((SUM(foi.total_freight_value) / SUM(foi.total_item_value)) * 100, 2) AS freight_share_pct

FROM `silent-matter-465213-p9.olist_raw.fact_orders` fo
LEFT JOIN `silent-matter-465213-p9.olist_raw.fact_order_items` foi
  ON fo.order_id = foi.order_id

GROUP BY
  EXTRACT(YEAR FROM fo.purchase_date),
  EXTRACT(MONTH FROM fo.purchase_date),
  FORMAT_DATE('%Y-%m', fo.purchase_date)

ORDER BY
  year DESC,
  month DESC;
