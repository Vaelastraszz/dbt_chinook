{% macro get_genre(genres) %}
WITH Metal_Rock AS (
    SELECT * 
    FROM {{ source('chinook_src', 'genre') }}
    WHERE Name IN {{ genres }}
),

Metal_Rock_Tracks AS (
    SELECT 
        t.track_id,
        t.Name,
        t.album_id AS AlbumId,
        a.title AS Album_Name,
        artist.name AS Artist_Name
    FROM 
        {{ source('chinook_src', 'track') }} t
        JOIN Metal_Rock m USING (genre_id) 
        JOIN album a USING (album_id) 
        JOIN artist USING (artist_id) 
)
{% endmacro %}