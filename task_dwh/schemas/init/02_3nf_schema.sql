-- 02_3nf_schema.sql
-- Normalized (3NF) Schema for Retail Sales System
SET search_path TO oltp_3nf;

-- Drop tables if they exist (for clean re-initialization)
DROP TABLE IF EXISTS Transaction_Items CASCADE;
DROP TABLE IF EXISTS Transactions CASCADE;
DROP TABLE IF EXISTS Customers CASCADE;
DROP TABLE IF EXISTS Store_Employees CASCADE;
DROP TABLE IF EXISTS Inventory CASCADE;
DROP TABLE IF EXISTS Products CASCADE;
DROP TABLE IF EXISTS Product_Types CASCADE;
DROP TABLE IF EXISTS Employees CASCADE;
DROP TABLE IF EXISTS Stores CASCADE;
DROP TABLE IF EXISTS Currency_Rates CASCADE;
DROP TABLE IF EXISTS Currencies CASCADE;
DROP TABLE IF EXISTS Countries CASCADE;

-- 1. Countries Table
CREATE TABLE Countries
(
    country_id SERIAL PRIMARY KEY,
    name       VARCHAR(100) NOT NULL,
    code       CHAR(2)      NOT NULL UNIQUE
);

-- 2. Currencies Table
CREATE TABLE Currencies
(
    currency_id SERIAL PRIMARY KEY,
    code        CHAR(3)     NOT NULL UNIQUE,
    name        VARCHAR(50) NOT NULL
);

-- 3. Currency_Rates Table
CREATE TABLE Currency_Rates
(
    rate_id        SERIAL PRIMARY KEY,
    currency_id    INT            NOT NULL,
    usd_rate       DECIMAL(16, 6) NOT NULL,
    effective_date DATE           NOT NULL,
    FOREIGN KEY (currency_id) REFERENCES Currencies (currency_id),
    UNIQUE (currency_id, effective_date)
);

-- 4. Stores Table
CREATE TABLE Stores
(
    store_id    SERIAL PRIMARY KEY,
    name        VARCHAR(100) NOT NULL,
    city        VARCHAR(100) NOT NULL,
    country_id  INT          NOT NULL,
    currency_id INT          NOT NULL,
    FOREIGN KEY (country_id) REFERENCES Countries (country_id),
    FOREIGN KEY (currency_id) REFERENCES Currencies (currency_id)
);

-- 5. Product_Types Table
CREATE TABLE Product_Types
(
    type_id SERIAL PRIMARY KEY,
    name    VARCHAR(50) NOT NULL UNIQUE
);

-- 6. Products Table
CREATE TABLE Products
(
    product_id        SERIAL PRIMARY KEY,
    name              VARCHAR(100)   NOT NULL,
    type_id           INT            NOT NULL,
    price             DECIMAL(10, 2) NOT NULL,
    currency_id       INT            NOT NULL,
    store_id          INT            NOT NULL,
    country_of_origin INT            NOT NULL,
    created_at        TIMESTAMP      NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (type_id) REFERENCES Product_Types (type_id),
    FOREIGN KEY (currency_id) REFERENCES Currencies (currency_id),
    FOREIGN KEY (store_id) REFERENCES Stores (store_id),
    FOREIGN KEY (country_of_origin) REFERENCES Countries (country_id)
);

-- 7. Inventory Table
CREATE TABLE Inventory
(
    inventory_id SERIAL PRIMARY KEY,
    product_id   INT       NOT NULL,
    store_id     INT       NOT NULL,
    quantity     INT       NOT NULL DEFAULT 0,
    last_updated TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES Products (product_id),
    FOREIGN KEY (store_id) REFERENCES Stores (store_id),
    UNIQUE (product_id, store_id)
);

-- 8. Employees Table
CREATE TABLE Employees
(
    employee_id      SERIAL PRIMARY KEY,
    first_name       VARCHAR(50) NOT NULL,
    last_name        VARCHAR(50) NOT NULL,
    date_of_birth    DATE        NOT NULL,
    country_of_birth INT         NOT NULL,
    FOREIGN KEY (country_of_birth) REFERENCES Countries (country_id)
);

-- 9. Store_Employees Table
CREATE TABLE Store_Employees
(
    assignment_id SERIAL PRIMARY KEY,
    store_id      INT  NOT NULL,
    employee_id   INT  NOT NULL,
    start_date    DATE NOT NULL,
    end_date      DATE NULL,
    FOREIGN KEY (store_id) REFERENCES Stores (store_id),
    FOREIGN KEY (employee_id) REFERENCES Employees (employee_id),
    UNIQUE (store_id, employee_id, start_date)
);

-- 10. Customers Table
CREATE TABLE Customers
(
    customer_id SERIAL PRIMARY KEY,
    first_name  VARCHAR(50) NOT NULL,
    last_name   VARCHAR(50) NOT NULL,
    created_at  TIMESTAMP   NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- 11. Transactions Table
CREATE TABLE Transactions
(
    transaction_id   SERIAL PRIMARY KEY,
    customer_id      INT       NOT NULL,
    employee_id      INT       NOT NULL,
    store_id         INT       NOT NULL,
    currency_id      INT       NOT NULL,
    transaction_time TIMESTAMP NOT NULL,
    last_updated     TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES Customers (customer_id),
    FOREIGN KEY (employee_id) REFERENCES Employees (employee_id),
    FOREIGN KEY (store_id) REFERENCES Stores (store_id),
    FOREIGN KEY (currency_id) REFERENCES Currencies (currency_id)
);

-- 12. Transaction_Items Table
CREATE TABLE Transaction_Items
(
    item_id        SERIAL PRIMARY KEY,
    transaction_id INT            NOT NULL,
    product_id     INT            NOT NULL,
    quantity       INT            NOT NULL,
    price_at_time  DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (transaction_id) REFERENCES Transactions (transaction_id),
    FOREIGN KEY (product_id) REFERENCES Products (product_id)
);