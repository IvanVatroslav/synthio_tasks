#!/bin/bash
# Script to run Snowflake schema report and save to CSV

# Run query with COPY command to generate CSV output
docker exec -i schema-examples-db psql -U admin -d warehouse_examples -c "COPY (
  SELECT
    dc.first_name AS \"Customer First Name\",
    dc.last_name AS \"Customer Last Name\",
    dp.name AS \"Product Name\",
    dp.price_usd AS \"Product Price In USD\",
    dpt.type_name AS \"Product Type\",
    fs.quantity AS \"Product Units Sold\",
    ds.name AS \"Store Name\",
    dci.city_name AS \"Store City\",
    dco.name AS \"Store Country\",
    dco.code AS \"Store Country Code\",
    de.first_name AS \"Clerk First Name\",
    de.last_name AS \"Clerk Last Name\",
    de.date_of_birth AS \"Clerk Date of Birth\",
    dcob.code AS \"Clerk Country of Birth\",
    dcur.code AS \"Currency Used\",
    fs.transaction_time AS \"Transaction Time\"
  FROM
    snowflake_dwh.FactSales fs
    JOIN snowflake_dwh.DimCustomer dc ON fs.customer_key = dc.customer_key
    JOIN snowflake_dwh.DimProduct dp ON fs.product_key = dp.product_key
    JOIN snowflake_dwh.DimProductType dpt ON dp.product_type_key = dpt.product_type_key
    JOIN snowflake_dwh.DimStore ds ON fs.store_key = ds.store_key
    JOIN snowflake_dwh.DimCity dci ON ds.city_key = dci.city_key
    JOIN snowflake_dwh.DimCountry dco ON dci.country_key = dco.country_key
    JOIN snowflake_dwh.DimEmployee de ON fs.employee_key = de.employee_key
    JOIN snowflake_dwh.DimCountry dcob ON de.country_of_birth_key = dcob.country_key
    JOIN snowflake_dwh.DimCurrency dcur ON fs.currency_key = dcur.currency_key
) TO STDOUT WITH CSV HEADER" > snowflake_report.csv

echo "Report saved to snowflake_report.csv"