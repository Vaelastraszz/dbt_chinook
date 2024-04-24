SELECT * 
FROM {{ref("staging_model_invoices")}}
WHERE invoice_total < 0
