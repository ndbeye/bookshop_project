{{ 
  config(
    materialized='view',
    alias='stg_ventes'
  ) 
}}

SELECT
  id AS sale_id,
  code AS sale_code,
  TRY_TO_DATE(date_edit, 'YYYYMMDD') AS sale_date,  -- Adaptez le format si nécessaire
  factures_id AS invoice_id,
  books_id AS book_id,
  pu AS unit_price,
  qte AS quantity,
  created_at
FROM {{ source('raw', 'ventes') }}