{{ config(materialized='incremental',
          unique_id = 'invoice_id, track_id',
          merge_exclude_columns = ['invoice_date', 'invoice_total', 'invoice_quantity', 'unit_price'],
          incremental_strategy='merge')
           }}
          

{% set tuples_tables_alias_keys = [
    ('customer', 'c', 'customer_id'),
    ('invoice_line', 'il', 'invoice_id'),
    ('track', 't', 'track_id'),
    ('album', 'a', 'album_id'),
    ('artist', 'ar', 'artist_id')
] %}

SELECT 
    -- Customer Information
    c.customer_id,
    c.first_name,
    c.last_name,
    c.company,
    c.state,
    c.country AS customer_country,
    c.postal_code,
    
    -- Invoice Information
    i.invoice_id,
    i.invoice_date,
    i.total AS invoice_total,
    Extract(YEAR FROM i.invoice_date) AS invoice_year,
    Extract(MONTH FROM i.invoice_date) AS invoice_month,
    
    -- Invoice Line Information
    il.track_id,
    il.quantity AS invoice_quantity,
    il.unit_price,
    
    -- Track Information
    t.name AS track_name,
    t.genre_id,
    
    -- Album Information
    a.title AS album_title,
    
    -- Artist Information
    ar.name AS artist_name
    
FROM 
    invoice i

{% for table, alias, key in tuples_tables_alias_keys %}
JOIN 
    {{ table }} {{ alias }} USING ({{ key }})
{% endfor %}

WHERE 
    i.total > 0

{% if is_incremental() %}
    AND i.invoice_date > (SELECT MAX(invoice_date) FROM {{ this }})
{% endif %}