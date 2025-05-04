
TRUNCATE TABLE location_incoming;
TRUNCATE TABLE book_incoming;
TRUNCATE TABLE book_location_incoming;

INSERT INTO location_incoming (address, city, province)
VALUES ('5150 Longworth Ave', 'Charlottetown', 'PE');

INSERT INTO location_incoming (address, city, province)
VALUES ('9190 Queen St', 'Victoria', 'BC');

--------------------------------------
-- book_location_incoming

INSERT INTO book_location_incoming (author, title, address, city, province, start_date, end_date) 
VALUES 
('Michael Lewis', 'The Undoing Project', 
'5150 Longworth Ave', 'Charlottetown', 'PE',
'2025-02-01', '2025-04-30');

INSERT INTO book_location_incoming (author, title, address, city, province, start_date, end_date) 
VALUES 
('Malcolm Gladwell', 'What The Dog Saw', 
'9190 Queen St', 'Victoria', 'BC',
'2024-12-01', '2025-01-01');

INSERT INTO book_location_incoming (author, title, address, city, province, start_date, end_date) 
VALUES 
('Malcolm Gladwell', 'What The Dog Saw', 
'7170 Robie St', 'Halifax', 'NS',
'2024-10-01', '2024-11-01');