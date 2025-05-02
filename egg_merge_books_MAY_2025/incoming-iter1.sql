
TRUNCATE TABLE location_incoming;
TRUNCATE TABLE book_incoming;

--------------------------------------
-- location_incoming

INSERT INTO location_incoming (address, city, province)
VALUES ('5150 Longworth Ave', 'Charlottetown', 'PE');

INSERT INTO location_incoming (address, city, province)
VALUES ('6160 Main St', 'Moncton', 'NB');

INSERT INTO location_incoming (address, city, province)
VALUES ('7170 Robie Ave', 'Halifax', 'NS');

INSERT INTO location_incoming (address, city, province)
VALUES ('8180 King St', 'Waterloo', 'ON');

--------------------------------------
-- book_incoming

INSERT INTO book_incoming (author, title) VALUES ('Michael Lewis', 'The Undoing Project');
INSERT INTO book_incoming (author, title) VALUES ('Malcolm Gladwell', 'What The Dog Saw');
INSERT INTO book_incoming (author, title) VALUES ('Robert Caro', 'Master Of The Senate');

