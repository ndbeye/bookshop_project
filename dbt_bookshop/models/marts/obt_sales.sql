{{
  config(
    materialized='table',
    alias='obt_sales',
    schema='MARTS'
  )
}}

WITH sales_data AS (
  SELECT
    fs.sale_id,
    fs.sale_date,
    COALESCE(fs.sale_year, EXTRACT(YEAR FROM fs.sale_date)) AS sale_year, -- Redondance sécurisée
    fs.sale_month,
    dc.full_name AS customer_name,
    db.book_title,
    db.category_name,
    ROUND(fs.unit_price, 2) AS unit_price, -- Arrondi monétaire
    fs.quantity,
    ROUND(fs.total_amount, 2) AS total_amount
  FROM {{ ref('fact_ventes') }} fs  <!-- Vérifier le nom exact du modèle -->
  INNER JOIN {{ ref('dim_customers') }} dc 
    ON fs.customer_id = dc.customer_id
    AND dc.valid_to IS NULL  -- Version courante des dimensions SCD2
  INNER JOIN {{ ref('dim_books') }} db 
    ON fs.book_id = db.book_id
    AND db.current_record = TRUE
)

SELECT *
FROM sales_data
WHERE sale_date BETWEEN '2023-01-01' AND CURRENT_DATE() -- Filtre de sécurité