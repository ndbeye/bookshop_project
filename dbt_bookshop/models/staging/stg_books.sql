{{ 
  config(
    materialized='view',
    alias='stg_books'
  ) 
}}

SELECT
  id AS book_id,
  category_id,
  code AS book_code,
  intitule AS book_title,
  isbn_10,
  isbn_13,
  created_at
FROM {{ source('raw', 'books') }}