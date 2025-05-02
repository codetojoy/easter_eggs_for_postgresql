
SELECT 
location_id, version, address, city, province,
to_char(created_on, 'Mon-DD HH24:MI:SS') as created_on,
to_char(updated_on, 'Mon-DD HH24:MI:SS') as updated_on	 
FROM location 
ORDER BY version desc, location_id asc;

SELECT 
book_id, version, author, title,
to_char(created_on, 'Mon-DD HH24:MI:SS') as created_on,
to_char(updated_on, 'Mon-DD HH24:MI:SS') as updated_on	 
FROM book 
ORDER BY version desc, book_id asc;
