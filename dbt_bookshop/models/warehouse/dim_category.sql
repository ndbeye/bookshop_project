{{ 
  config(
    materialized='table',
    alias='dim_category'
  ) 
}}

SELECT
  category_id,
  category_name,
  created_at
FROM {{ ref('stg_category') }}