
TRUNCATE TABLE location_incoming;
TRUNCATE TABLE book_incoming;

--------------------------------------
-- location_incoming

INSERT INTO location_incoming (address, city, province)
VALUES ('5150 Longworth Ave', 'Charlottetown', 'PE');

INSERT INTO location_incoming (address, city, province)
VALUES ('6160 Main St', 'Moncton', 'NB');

INSERT INTO location_incoming (address, city, province)
VALUES ('7170 Robie St', 'Halifax', 'NS');

INSERT INTO location_incoming (address, city, province)
VALUES ('8180 King St', 'Waterloo', 'ON');

--------------------------------------
-- book_incoming

INSERT INTO book_incoming (author, title) VALUES ('Michael Lewis', 'The Undoing Project');
INSERT INTO book_incoming (author, title) VALUES ('Malcolm Gladwell', 'What The Dog Saw');
INSERT INTO book_incoming (author, title) VALUES ('Robert Caro', 'Master Of The Senate');

--------------------------------------
-- book_location_incoming

INSERT INTO book_location_incoming (author, title, address, city, province, start_date, end_date) 
VALUES 
('Michael Lewis', 'The Undoing Project', 
'5150 Longworth Ave', 'Charlottetown', 'PE',
'2025-02-01', '2025-04-30');

INSERT INTO book_location_incoming (author, title, address, city, province, start_date, end_date) 
VALUES 
('Michael Lewis', 'The Undoing Project', 
'8180 King St', 'Waterloo', 'ON',
'2025-05-01', null);