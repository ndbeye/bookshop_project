{{ 
  config(
    materialized='view',
    alias='stg_customers'
  ) 
}}

SELECT
  id AS customer_id,
  code AS customer_code,
  first_name,
  last_name,
  created_at
FROM {{ source('raw', 'customers') }}