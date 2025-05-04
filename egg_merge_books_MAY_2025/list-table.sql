
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

SELECT 
b.title, b.author,
l.address, l.city, l.province,
bl.version,
to_char(bl.start_date, 'YYYY-MM-DD') as start_date,
to_char(bl.end_date, 'YYYY-MM-DD') as end_date
FROM book_location bl
JOIN book b ON b.book_id = bl.book_id
JOIN location l ON l.location_id = bl.location_id
ORDER BY bl.version desc, bl.end_date desc;

