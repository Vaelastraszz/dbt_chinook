{{ config(materialized='view') }}

Select *
from {{ source('chinook_src', 'worldcities') }}
where country = 'United States'