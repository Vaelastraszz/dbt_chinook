 {{
  config(
    materialized = 'ephemeral',
    )
}}

with invoices as (
    select 
        customer_id,
        invoice_id,
        first_name,
        last_name,
        invoice_date
    from {{ ref('incremental_invoices') }}
    where customer_country = 'USA'
)

select * from invoices