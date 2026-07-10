CREATE OR REPLACE TABLE orders AS
SELECT *
FROM read_csv_auto('data/raw/orders.csv');

CREATE OR REPLACE TABLE products AS
SELECT *
FROM read_csv_auto('data/raw/products.csv');

CREATE OR REPLACE TABLE aisles AS
SELECT *
FROM read_csv_auto('data/raw/aisles.csv');

CREATE OR REPLACE TABLE departments AS
SELECT *
FROM read_csv_auto('data/raw/departments.csv');

CREATE OR REPLACE TABLE order_products_prior AS
SELECT *
FROM read_csv_auto('data/raw/order_products__prior.csv');

CREATE OR REPLACE TABLE order_products_train AS
SELECT *
FROM read_csv_auto('data/raw/order_products__train.csv');

CREATE OR REPLACE TABLE order_products AS
    SELECT *
    FROM order_products_prior
    UNION ALL
    SELECT *
    FROM order_products_train;
