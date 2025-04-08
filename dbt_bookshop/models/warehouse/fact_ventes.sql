{{ 
  config(
    materialized='table',
    schema='WAREHOUSE',
    alias='fact_ventes'
) }}

SELECT
    s.sale_id,
    TRY_TO_DATE(s.sale_date, 'YYYYMMDD') AS sale_date,
    EXTRACT(YEAR FROM TRY_TO_DATE(s.sale_date, 'YYYYMMDD')) AS sale_year,
    EXTRACT(MONTH FROM TRY_TO_DATE(s.sale_date, 'YYYYMMDD')) AS sale_month,
    DECODE(EXTRACT(MONTH FROM TRY_TO_DATE(s.sale_date, 'YYYYMMDD')),
        1, 'janvier', 2, 'février', 3, 'mars', 4, 'avril',
        5, 'mai', 6, 'juin', 7, 'juillet', 8, 'août',
        9, 'septembre', 10, 'octobre', 11, 'novembre', 12, 'décembre'
    ) AS mois,
    DECODE(DAYOFWEEK(TRY_TO_DATE(s.sale_date, 'YYYYMMDD')),
        1, 'dimanche', 2, 'lundi', 3, 'mardi', 4, 'mercredi',
        5, 'jeudi', 6, 'vendredi', 7, 'samedi'
    ) AS jour,
    d.book_id,
    c.category_id,
    i.customer_id,
    s.unit_price,
    s.quantity,
    s.unit_price * s.quantity AS total_amount
FROM {{ ref('stg_ventes') }} s
JOIN {{ ref('dim_books') }} d ON s.book_id = d.book_id
JOIN {{ ref('dim_category') }} c ON d.category_id = c.category_id
JOIN {{ ref('stg_factures') }} i ON s.invoice_id = i.invoice_id
