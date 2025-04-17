-- Query to generate sales report from 3NF schema
SELECT c.first_name       AS "Customer First Name",
       c.last_name        AS "Customer Last Name",
       p.name             AS "Product Name",
       p.price            AS "Product Price In USD",
       pt.name            AS "Product Type",
       ti.quantity        AS "Product Units Sold",
       s.name             AS "Store Name",
       s.city             AS "Store City",
       co.name            AS "Store Country",
       co.code            AS "Store Country Code",
       e.first_name       AS "Clerk First Name",
       e.last_name        AS "Clerk Last Name",
       e.date_of_birth    AS "Clerk Date of Birth",
       cob.code           AS "Clerk Country of Birth",
       cur.code           AS "Currency Used",
       t.transaction_time AS "Transaction Time"
FROM oltp_3nf.Transactions t
         JOIN oltp_3nf.Customers c ON t.customer_id = c.customer_id
         JOIN oltp_3nf.Employees e ON t.employee_id = e.employee_id
         JOIN oltp_3nf.Countries cob ON e.country_of_birth = cob.country_id
         JOIN oltp_3nf.Stores s ON t.store_id = s.store_id
         JOIN oltp_3nf.Countries co ON s.country_id = co.country_id
         JOIN oltp_3nf.Currencies cur ON t.currency_id = cur.currency_id
         JOIN oltp_3nf.Transaction_Items ti ON t.transaction_id = ti.transaction_id
         JOIN oltp_3nf.Products p ON ti.product_id = p.product_id
         JOIN oltp_3nf.Product_Types pt ON p.type_id = pt.type_id;