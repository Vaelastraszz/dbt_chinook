{{ config(materialized='view') }}

SELECT
    customer_country,
    COUNT(DISTINCT customer_id) AS customer_count,
    ROUND(AVG(invoice_total),2) AS avg_invoice_total
FROM
    {{ ref('staging_model_invoices') }}
GROUP BY
    customer_country