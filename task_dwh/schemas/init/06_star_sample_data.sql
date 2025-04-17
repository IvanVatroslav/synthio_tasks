-- 06_star_sample_data.sql
SET search_path TO star_dwh;

-- Populate date dimension for the transaction date
INSERT INTO DimDate
(date_key, date, day, month, month_name, quarter, year, day_of_week, day_name, is_weekend, is_holiday, fiscal_year)
VALUES (20230413, '2023-04-13', 13, 4, 'April', 2, 2023, 4, 'Thursday', FALSE, FALSE, 2023);

-- Populate currency dimension
INSERT INTO DimCurrency
    (currency_id, code, name, valid_from, is_current)
VALUES (1, 'USD', 'US Dollar', '2023-01-01 00:00:00', TRUE) ,
    (2, 'HRK', 'Croatian Kuna', '2023-01-01 00:00:00', TRUE);

-- Populate customer dimension
INSERT INTO DimCustomer
    (customer_id, first_name, last_name, full_name, valid_from, is_current)
VALUES (1, 'Filip', 'Milic', 'Filip Milic', '2023-01-01 00:00:00', TRUE);

-- Populate product dimension
INSERT INTO DimProduct
    (product_id, name, type, price_usd, valid_from, is_current)
VALUES (1, 'Biscuits', 'Food', 20.00, '2023-01-01 00:00:00', TRUE);

-- Populate store dimension
INSERT INTO DimStore
(store_id, name, city, country, country_code, primary_currency_code, valid_from, is_current)
VALUES (1, 'Syntio', 'LA', 'United States', 'US', 'USD', '2023-01-01 00:00:00', TRUE);

-- Populate employee dimension
INSERT INTO DimEmployee
(employee_id, first_name, last_name, full_name, date_of_birth, country_of_birth, country_of_birth_code, valid_from,
 is_current)
VALUES (1, 'Nikola', 'Tomazin', 'Nikola Tomazin', '1997-04-13', 'Croatia', 'HR', '2023-01-01 00:00:00', TRUE);

-- Populate fact table
INSERT INTO FactSales
(transaction_id, transaction_item_id, customer_key, product_key, store_key, employee_key, date_key, currency_key,
 transaction_hour, transaction_minute, quantity, price_per_unit_local, price_per_unit_usd, total_price_local,
 total_price_usd, transaction_time)
VALUES (1, 1, 1, 1, 1, 1, 20230413, 2, 18, 4, 10, 150.00, 20.00, 1500.00, 200.00, '2023-04-13T18:04:21.789965');