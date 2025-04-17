-- 07_snowflake_sample_data.sql
SET search_path TO snowflake_dwh;

-- Populate date dimension
INSERT INTO DimDate
(date_key, date, day, month, month_name, quarter, year, day_of_week, day_name, is_weekend, is_holiday, fiscal_year)
VALUES (20230413, '2023-04-13', 13, 4, 'April', 2, 2023, 4, 'Thursday', FALSE, FALSE, 2023);

-- Populate currency dimension
INSERT INTO DimCurrency
    (currency_id, code, name, valid_from, is_current)
VALUES (1, 'USD', 'US Dollar', '2023-01-01 00:00:00', TRUE) ,
    (2, 'HRK', 'Croatian Kuna', '2023-01-01 00:00:00', TRUE);

-- Populate country dimension
INSERT INTO DimCountry
    (country_id, name, code, valid_from, is_current)
VALUES (1, 'United States', 'US', '2023-01-01 00:00:00', TRUE) ,
    (2, 'Croatia', 'HR', '2023-01-01 00:00:00', TRUE);

-- Populate city dimension
INSERT INTO DimCity
    (city_name, country_key, valid_from, is_current)
VALUES ('LA', 1, '2023-01-01 00:00:00', TRUE);

-- Populate store dimension
INSERT INTO DimStore
(store_id, name, city_key, primary_currency_key, valid_from, is_current)
VALUES (1, 'Syntio', 1, 1, '2023-01-01 00:00:00', TRUE);

-- Populate product type dimension
INSERT INTO DimProductType
    (type_id, type_name, valid_from, is_current)
VALUES (1, 'Food', '2023-01-01 00:00:00', TRUE);

-- Populate product dimension
INSERT INTO DimProduct
(product_id, name, product_type_key, price_usd, country_of_origin_key, valid_from, is_current)
VALUES (1, 'Biscuits', 1, 20.00, 1, '2023-01-01 00:00:00', TRUE);

-- Populate employee dimension
INSERT INTO DimEmployee
(employee_id, first_name, last_name, full_name, date_of_birth, country_of_birth_key, valid_from, is_current)
VALUES (1, 'Nikola', 'Tomazin', 'Nikola Tomazin', '1997-04-13', 2, '2023-01-01 00:00:00', TRUE);

-- Populate customer dimension
INSERT INTO DimCustomer
    (customer_id, first_name, last_name, full_name, valid_from, is_current)
VALUES (1, 'Filip', 'Milic', 'Filip Milic', '2023-01-01 00:00:00', TRUE);

-- Populate fact table
INSERT INTO FactSales
(transaction_id, transaction_item_id, customer_key, product_key, store_key, employee_key, date_key, currency_key,
 transaction_hour, transaction_minute, quantity, price_per_unit_local, price_per_unit_usd, total_price_local,
 total_price_usd, transaction_time)
VALUES (1, 1, 1, 1, 1, 1, 20230413, 2, 18, 4, 10, 150.00, 20.00, 1500.00, 200.00, '2023-04-13T18:04:21.789965');