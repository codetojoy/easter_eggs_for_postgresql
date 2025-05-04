
---------------------
-- location 

MERGE INTO location loc
USING location_incoming li
ON loc.address = li.address AND loc.city = li.city AND loc.province = li.province
WHEN MATCHED THEN
  UPDATE set version = loc.version + 1, updated_on = default
WHEN NOT MATCHED THEN
  INSERT (address, city, province)
  VALUES (li.address, li.city, li.province);

---------------------
-- book 

MERGE INTO book b
USING book_incoming bi
ON b.author = bi.author AND b.title = bi.title
WHEN MATCHED THEN
  UPDATE set version = b.version + 1, updated_on = default
WHEN NOT MATCHED THEN
  INSERT (author, title)
  VALUES (bi.author, bi.title);

---------------------
-- populate book_location_incoming with primary keys  

UPDATE book_location_incoming bli
set book_id = (SELECT b.book_id FROM book b
WHERE b.author = bli.author AND b.title = bli.title);

UPDATE book_location_incoming bli
set location_id = (SELECT l.location_id FROM location l
WHERE l.address = bli.address AND l.city = bli.city AND l.province = bli.province);

---------------------
-- book_location 

MERGE INTO book_location bl
USING book_location_incoming bli
ON bl.book_id = bli.book_id AND bl.location_id = bli.location_id
AND bl.start_date = bli.start_date AND bl.end_date = bli.end_date
WHEN MATCHED THEN
  UPDATE set version = bl.version + 1, updated_on = default
WHEN NOT MATCHED THEN
  INSERT (book_id, location_id, start_date, end_date)
  VALUES (bli.book_id, bli.location_id, bli.start_date, bli.end_date);

