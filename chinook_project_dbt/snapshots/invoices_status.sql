{% {% snapshot invoices_status_snapshot %}

{{
   config(
       target_schema='snapshots',
       unique_key='invoice_id',
       strategy='timestamp',
       updated_at='updated_at',
   )
}}

SELECT * FROM {{ source('chinook_src', 'invoice')}}

{% endsnapshot %}%}