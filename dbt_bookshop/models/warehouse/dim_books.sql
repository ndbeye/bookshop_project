{{ 
  config(
    materialized='table',
    alias='dim_books'
  ) 
}}

SELECT
  b.book_id,
  b.book_code,
  b.book_title,
  b.isbn_10,
  b.isbn_13,
  c.category_name
FROM {{ ref('stg_books') }} b
LEFT JOIN {{ ref('stg_category') }} c ON b.category_id = c.category_id