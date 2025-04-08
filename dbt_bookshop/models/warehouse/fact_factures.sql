{{ 
  config(
    materialized='table',
    schema='WAREHOUSE',
    alias='fact_factures'
  ) 
}}

SELECT
    f.invoice_id,
    f.total_amount,
    f.total_paid,
    f.total_amount - f.total_paid AS balance_due,
    c.customer_id,
    TRY_TO_DATE(f.edit_date, 'YYYYMMDD') AS invoice_date,
    EXTRACT(QUARTER FROM TRY_TO_DATE(f.edit_date, 'YYYYMMDD')) AS fiscal_quarter
FROM {{ ref('stg_factures') }} f
JOIN {{ ref('dim_customers') }} c 
    ON f.customers_id = c.customer_code
