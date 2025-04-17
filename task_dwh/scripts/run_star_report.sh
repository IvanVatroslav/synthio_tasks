#!/bin/bash
# Script to run Star schema report and save to CSV

# Run query with COPY command to generate CSV output
docker exec -i schema-examples-db psql -U admin -d warehouse_examples -c "COPY (
  SELECT
    dc.first_name AS \"Customer First Name\",
    dc.last_name AS \"Customer Last Name\",
    dp.name AS \"Product Name\",
    dp.price_usd AS \"Product Price In USD\",
    dp.type AS \"Product Type\",
    fs.quantity AS \"Product Units Sold\",
    ds.name AS \"Store Name\",
    ds.city AS \"Store City\",
    ds.country AS \"Store Country\",
    ds.country_code AS \"Store Country Code\",
    de.first_name AS \"Clerk First Name\",
    de.last_name AS \"Clerk Last Name\",
    de.date_of_birth AS \"Clerk Date of Birth\",
    de.country_of_birth_code AS \"Clerk Country of Birth\",
    dcur.code AS \"Currency Used\",
    fs.transaction_time AS \"Transaction Time\"
  FROM
    star_dwh.FactSales fs
    JOIN star_dwh.DimCustomer dc ON fs.customer_key = dc.customer_key
    JOIN star_dwh.DimProduct dp ON fs.product_key = dp.product_key
    JOIN star_dwh.DimStore ds ON fs.store_key = ds.store_key
    JOIN star_dwh.DimEmployee de ON fs.employee_key = de.employee_key
    JOIN star_dwh.DimCurrency dcur ON fs.currency_key = dcur.currency_key
) TO STDOUT WITH CSV HEADER" > star_report.csv

echo "Report saved to star_report.csv"