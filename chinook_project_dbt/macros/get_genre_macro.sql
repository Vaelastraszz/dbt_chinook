{% macro get_genre(genres) %}
{% set table_list = [
    "metal_rock",
    "album",
    "artist"
] %}

{% set key_list = [
    "genre_id",
    "album_id",
    "artist_id"
]%}

{%set aliases = [
    "m",
    "a",
    ""
]%}


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
        {%- for table, key, alias in zip(table_list, key_list, aliases) %}
        JOIN {{ table }} {{ alias }} USING ({{ key }})
        {% endfor %}
)
{% endmacro %}