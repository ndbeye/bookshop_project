{{ 
  config(
    materialized='view',
    alias='stg_category'
  ) 
}}

SELECT
  id AS category_id,
  intitule AS category_name,
  created_at
FROM {{ source('raw', 'category') }}