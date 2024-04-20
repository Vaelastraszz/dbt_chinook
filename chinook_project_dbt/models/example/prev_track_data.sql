{{ config(materialized='view') }}

{% set list_prev_cols = [
    'List_Track_Name',
    'Album_Name',
    'invoice_date'
]%}
{{ get_track_sold() }}

SELECT 
    *,
   {% for col in list_prev_cols %}
    LAG({{ col }}, 1) OVER (PARTITION BY customer_id ORDER BY invoice_date ASC) AS prev_{{ col }}
    {%- if not loop.last %},{% endif -%}
    {% endfor %}
FROM 
    list_track_sold