{{ config(
    materialized = 'view',
    )
}}

select * from {{ ref('ephemeral_invoices') }}