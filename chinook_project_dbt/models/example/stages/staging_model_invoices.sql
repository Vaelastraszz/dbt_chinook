{{ config(materialized='table') }}

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
JOIN 
    customer c USING (customer_id)
JOIN 
    invoice_line il USING (invoice_id)
JOIN 
    track t USING (track_id)
JOIN 
    album a USING (album_id)
JOIN 
    artist ar USING (artist_id)

WHERE 
    i.total > 0
