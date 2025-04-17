SET search_path TO oltp_3nf;

-- Countries
INSERT INTO Countries (name, code)
VALUES ('United States', 'US') ,
    ('Croatia', 'HR');

-- Currencies
INSERT INTO Currencies (code, name)
VALUES ('USD', 'US Dollar') ,
    ('HRK', 'Croatian Kuna');

-- Currency rates
INSERT INTO Currency_Rates (currency_id, usd_rate, effective_date)
VALUES (1, 1.0, '2023-04-13') ,
    (2, 0.133, '2023-04-13');

-- Product types
INSERT INTO Product_Types (name)
VALUES ('Food');

-- Store
INSERT INTO Stores (name, city, country_id, currency_id)
VALUES ('Syntio', 'LA', 1, 1);

-- Employee
INSERT INTO Employees (first_name, last_name, date_of_birth, country_of_birth)
VALUES ('Nikola', 'Tomazin', '1997-04-13', 2);

-- Store-Employee relationship
INSERT INTO Store_Employees (store_id, employee_id, start_date)
VALUES (1, 1, '2022-01-01');

-- Product
INSERT INTO Products (name, type_id, price, currency_id, store_id, country_of_origin)
VALUES ('Biscuits', 1, 20, 1, 1, 1);

-- Inventory
INSERT INTO Inventory (product_id, store_id, quantity)
VALUES (1, 1, 100);

-- Customer
INSERT INTO Customers (first_name, last_name)
VALUES ('Filip', 'Milic');

-- Transaction
INSERT INTO Transactions (customer_id, employee_id, store_id, currency_id, transaction_time)
VALUES (1, 1, 1, 2, '2023-04-13T18:04:21.789965');

-- Transaction item
INSERT INTO Transaction_Items (transaction_id, product_id, quantity, price_at_time)
VALUES (1, 1, 10, 20);