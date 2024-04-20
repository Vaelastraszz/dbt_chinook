{% macro get_track_sold() %}

{% set table_list = [
    'customer',
    'invoice_line',
    'track',
    'album'
] %}

{% set key_list = [
    'customer_id',
    'invoice_id',
    'track_id',
    'album_id'
]%}

WITH list_track_sold AS (
    SELECT
        customer_id, 
        first_name,
        last_name,
        -- Concatenate track names for each customer and invoice date
        STRING_AGG(track.name,',') AS List_Track_Name,
        -- Retrieve the album title for each customer and invoice date
        album.title AS Album_Name, 
        -- Retrieve the invoice date for each customer and invoice date
        i.invoice_date
    FROM 
        {{ source('chinook_src', 'invoice') }} i
        {% for table, key in zip(table_list, key_list) %}
        JOIN {{ source('chinook_src', table) }} USING ({{ key }})
        {% endfor %}
    GROUP BY 
        customer_id, first_name, last_name, i.invoice_date, album.title
)
{% endmacro %}