{{ config(materialized='view') }}

{% set genres = ('Metal', 'Rock And Roll')%}
{{get_genre(genres)}}

SELECT 
    track_id,
    Name, 
    Album_Name, 
    Artist_Name, 
    SUM(Quantity) AS Quantity_total
FROM 
    {{source('chinook_src', 'invoice_line')}}
    JOIN Metal_Rock_Tracks USING (track_id) 
GROUP BY 
    1, 2, 3, 4
ORDER BY 
    Quantity_total DESC
