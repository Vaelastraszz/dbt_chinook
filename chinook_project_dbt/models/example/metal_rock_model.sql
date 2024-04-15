{{ config(materialized='view') }}

{% set genres = ('Metal', 'Rock And Roll')%}
{{get_genre(genres)}}

SELECT 
    TrackId,
    Name, 
    Album_Name, 
    Artist_Name, 
    SUM(Quantity) AS Quantity_total
FROM 
    {{source('chinook', 'invoice_line')}}
    JOIN Metal_Rock_Tracks USING (TrackId) 
GROUP BY 
    1, 2, 3 
ORDER BY 
    Quantity_total DESC;
