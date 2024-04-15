{% macro get_genre(genres) %}
WITH Metal_Rock AS (
    SELECT * 
    FROM {{ source('chinook', 'genre') }}
    WHERE Name IN {{ genres }}
),

Metal_Rock_Tracks AS (
    SELECT 
        t.TrackId,
        t.Name,
        t.AlbumId,
        a.Title AS Album_Name,
        artists.Name AS Artist_Name
    FROM 
        {{ source('chinook', 'track') }} t
        JOIN Metal_Rock m USING (GenreId) 
        JOIN albums a USING (AlbumId) 
        JOIN artists USING (ArtistId) 
)
{% endmacro %}