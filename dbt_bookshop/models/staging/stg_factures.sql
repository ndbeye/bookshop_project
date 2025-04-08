{{ 
  config(
    materialized='view',
    alias='stg_factures'
  ) 
}}

SELECT
  id AS invoice_id,
  code AS invoice_code,
  TRY_TO_DATE(date_edit, 'YYYYMMDD') AS edit_date,  -- Adaptez le format si nécessaire
  customers_id,
  qte_totale AS total_quantity,
  total_amount,
  total_paid,
  created_at
FROM {{ source('raw', 'factures') }}