-- ============================================================================
-- 01_schema_and_load.sql
-- E-Commerce Analytics Pipeline | Google BigQuery
-- Purpose: Create dataset, tables, and load Olist e-commerce sample data
-- ============================================================================

-- Step 1: Create Dataset
-- Run this once to create the schema
CREATE SCHEMA IF NOT EXISTS olist_ecommerce
OPTIONS (
  description = 'Brazilian E-Commerce dataset from Olist'
);

-- Step 2: Create Tables
-- Note: For this portfolio project, sample data is used.
-- In production, full dataset would be loaded from Kaggle CSVs.

-- Customers Table
CREATE OR REPLACE TABLE olist_ecommerce.customers (
  customer_id STRING,
  customer_unique_id STRING,
  customer_zip_code_prefix STRING,
  customer_city STRING,
  customer_state STRING
);

-- Orders Table
CREATE OR REPLACE TABLE olist_ecommerce.orders (
  order_id STRING,
  customer_id STRING,
  order_status STRING,
  order_purchase_timestamp TIMESTAMP,
  order_approved_at TIMESTAMP,
  order_delivered_carrier_date TIMESTAMP,
  order_delivered_customer_date TIMESTAMP,
  order_estimated_delivery_date TIMESTAMP
);

-- Order Items Table
CREATE OR REPLACE TABLE olist_ecommerce.order_items (
  order_id STRING,
  order_item_id INT64,
  product_id STRING,
  seller_id STRING,
  shipping_limit_date TIMESTAMP,
  price FLOAT64,
  freight_value FLOAT64
);

-- Products Table
CREATE OR REPLACE TABLE olist_ecommerce.products (
  product_id STRING,
  product_category_name STRING,
  product_name_length INT64,
  product_description_length INT64,
  product_photos_qty INT64,
  product_weight_g INT64,
  product_length_cm INT64,
  product_height_cm INT64,
  product_width_cm INT64
);

-- Payments Table
CREATE OR REPLACE TABLE olist_ecommerce.payments (
  order_id STRING,
  payment_sequential INT64,
  payment_type STRING,
  payment_installments INT64,
  payment_value FLOAT64
);

-- ============================================================================
-- Sample Data Insertion (for portfolio demonstration)
-- In production, use: LOAD DATA or Python ETL to insert full CSV data
-- ============================================================================

INSERT INTO olist_ecommerce.customers (customer_id, customer_unique_id, customer_zip_code_prefix, customer_city, customer_state)
VALUES
  ('CUST001', 'UNIQ001', '01310-100', 'Sao Paulo', 'SP'),
  ('CUST002', 'UNIQ002', '20040-020', 'Rio de Janeiro', 'RJ'),
  ('CUST003', 'UNIQ003', '30130-010', 'Belo Horizonte', 'MG'),
  ('CUST004', 'UNIQ004', '80010-030', 'Curitiba', 'PR'),
  ('CUST005', 'UNIQ005', '90010-020', 'Porto Alegre', 'RS');

INSERT INTO olist_ecommerce.orders (order_id, customer_id, order_status, order_purchase_timestamp, order_approved_at, order_delivered_carrier_date, order_delivered_customer_date, order_estimated_delivery_date)
VALUES
  ('ORD001', 'CUST001', 'delivered', TIMESTAMP '2024-01-05 10:30:00', TIMESTAMP '2024-01-05 11:00:00', TIMESTAMP '2024-01-06 09:00:00', TIMESTAMP '2024-01-09 14:00:00', TIMESTAMP '2024-01-10 18:00:00'),
  ('ORD002', 'CUST002', 'delivered', TIMESTAMP '2024-01-10 14:20:00', TIMESTAMP '2024-01-10 15:00:00', TIMESTAMP '2024-01-11 10:00:00', TIMESTAMP '2024-01-13 16:00:00', TIMESTAMP '2024-01-14 18:00:00'),
  ('ORD003', 'CUST003', 'delivered', TIMESTAMP '2024-01-15 09:00:00', TIMESTAMP '2024-01-15 10:00:00', TIMESTAMP '2024-01-16 08:00:00', TIMESTAMP '2024-01-18 12:00:00', TIMESTAMP '2024-01-17 18:00:00'),
  ('ORD004', 'CUST001', 'delivered', TIMESTAMP '2024-01-20 11:00:00', TIMESTAMP '2024-01-20 12:00:00', TIMESTAMP '2024-01-21 09:00:00', TIMESTAMP '2024-01-23 15:00:00', TIMESTAMP '2024-01-24 18:00:00'),
  ('ORD005', 'CUST004', 'shipped', TIMESTAMP '2024-02-01 08:30:00', TIMESTAMP '2024-02-01 09:00:00', TIMESTAMP '2024-02-02 10:00:00', NULL, TIMESTAMP '2024-02-05 18:00:00'),
  ('ORD006', 'CUST002', 'delivered', TIMESTAMP '2024-02-05 13:00:00', TIMESTAMP '2024-02-05 14:00:00', TIMESTAMP '2024-02-06 09:00:00', TIMESTAMP '2024-02-08 11:00:00', TIMESTAMP '2024-02-09 18:00:00'),
  ('ORD007', 'CUST005', 'delivered', TIMESTAMP '2024-02-10 10:00:00', TIMESTAMP '2024-02-10 11:00:00', TIMESTAMP '2024-02-11 08:00:00', TIMESTAMP '2024-02-14 16:00:00', TIMESTAMP '2024-02-13 18:00:00'),
  ('ORD008', 'CUST003', 'delivered', TIMESTAMP '2024-02-15 15:00:00', TIMESTAMP '2024-02-15 16:00:00', TIMESTAMP '2024-02-16 09:00:00', TIMESTAMP '2024-02-19 14:00:00', TIMESTAMP '2024-02-18 18:00:00'),
  ('ORD009', 'CUST001', 'delivered', TIMESTAMP '2024-02-20 09:00:00', TIMESTAMP '2024-02-20 10:00:00', TIMESTAMP '2024-02-21 08:00:00', TIMESTAMP '2024-02-23 12:00:00', TIMESTAMP '2024-02-24 18:00:00'),
  ('ORD010', 'CUST004', 'delivered', TIMESTAMP '2024-03-01 11:00:00', TIMESTAMP '2024-03-01 12:00:00', TIMESTAMP '2024-03-02 09:00:00', TIMESTAMP '2024-03-04 15:00:00', TIMESTAMP '2024-03-05 18:00:00');

INSERT INTO olist_ecommerce.order_items (order_id, order_item_id, product_id, seller_id, shipping_limit_date, price, freight_value)
VALUES
  ('ORD001', 1, 'PROD001', 'SELL001', TIMESTAMP '2024-01-06 18:00:00', 299.99, 15.00),
  ('ORD002', 1, 'PROD002', 'SELL002', TIMESTAMP '2024-01-11 18:00:00', 149.50, 10.00),
  ('ORD002', 2, 'PROD003', 'SELL001', TIMESTAMP '2024-01-11 18:00:00', 89.99, 8.00),
  ('ORD003', 1, 'PROD001', 'SELL003', TIMESTAMP '2024-01-16 18:00:00', 299.99, 20.00),
  ('ORD004', 1, 'PROD004', 'SELL002', TIMESTAMP '2024-01-21 18:00:00', 549.99, 25.00),
  ('ORD005', 1, 'PROD005', 'SELL001', TIMESTAMP '2024-02-02 18:00:00', 199.99, 12.00),
  ('ORD006', 1, 'PROD002', 'SELL003', TIMESTAMP '2024-02-06 18:00:00', 149.50, 10.00),
  ('ORD006', 2, 'PROD006', 'SELL002', TIMESTAMP '2024-02-06 18:00:00', 79.99, 7.00),
  ('ORD007', 1, 'PROD003', 'SELL001', TIMESTAMP '2024-02-11 18:00:00', 89.99, 8.00),
  ('ORD008', 1, 'PROD004', 'SELL003', TIMESTAMP '2024-02-16 18:00:00', 549.99, 25.00),
  ('ORD009', 1, 'PROD005', 'SELL002', TIMESTAMP '2024-02-21 18:00:00', 199.99, 12.00),
  ('ORD010', 1, 'PROD006', 'SELL001', TIMESTAMP '2024-03-02 18:00:00', 79.99, 7.00);

INSERT INTO olist_ecommerce.products (product_id, product_category_name, product_name_length, product_description_length, product_photos_qty, product_weight_g, product_length_cm, product_height_cm, product_width_cm)
VALUES
  ('PROD001', 'electronics', 45, 120, 5, 500, 20, 10, 15),
  ('PROD002', 'home_decor', 38, 95, 3, 800, 30, 15, 20),
  ('PROD003', 'sports_leisure', 32, 80, 4, 300, 25, 12, 18),
  ('PROD004', 'electronics', 52, 150, 6, 1200, 40, 20, 30),
  ('PROD005', 'fashion', 28, 70, 3, 200, 15, 8, 10),
  ('PROD006', 'home_decor', 35, 88, 4, 600, 28, 14, 18);

INSERT INTO olist_ecommerce.payments (order_id, payment_sequential, payment_type, payment_installments, payment_value)
VALUES
  ('ORD001', 1, 'credit_card', 3, 314.99),
  ('ORD002', 1, 'credit_card', 2, 257.49),
  ('ORD003', 1, 'boleto', 1, 319.99),
  ('ORD004', 1, 'credit_card', 6, 574.99),
  ('ORD005', 1, 'debit_card', 1, 211.99),
  ('ORD006', 1, 'credit_card', 1, 159.50),
  ('ORD006', 2, 'credit_card', 1, 86.99),
  ('ORD007', 1, 'boleto', 1, 97.99),
  ('ORD008', 1, 'credit_card', 4, 574.99),
  ('ORD009', 1, 'credit_card', 2, 211.99),
  ('ORD010', 1, 'debit_card', 1, 86.99);
