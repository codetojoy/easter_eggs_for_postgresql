
DROP TABLE IF EXISTS book_location;
DROP TABLE IF EXISTS book;
DROP TABLE IF EXISTS location;

DROP TABLE IF EXISTS location_incoming;
DROP TABLE IF EXISTS book_incoming;

CREATE TABLE location_incoming (
    address VARCHAR(255),
    city VARCHAR(255),
    province VARCHAR(255)
);

CREATE TABLE location (
    location_id  SERIAL PRIMARY KEY,
    address VARCHAR(255),
    city VARCHAR(255),
    province VARCHAR(255),
    version INTEGER DEFAULT 1,
    created_on TIMESTAMP DEFAULT current_timestamp,
    updated_on TIMESTAMP DEFAULT current_timestamp
);

CREATE TABLE book_incoming (
    title VARCHAR(255),
    author VARCHAR(255)
);

CREATE TABLE book (
    book_id  SERIAL PRIMARY KEY,
    title VARCHAR(255),
    author VARCHAR(255),
    version INTEGER DEFAULT 1,
    created_on TIMESTAMP DEFAULT current_timestamp,
    updated_on TIMESTAMP DEFAULT current_timestamp
);

CREATE TABLE book_location (
    book_id  INTEGER,
    location_id INTEGER,
    active BOOLEAN DEFAULT true,
    version INTEGER DEFAULT 1,
    created_on TIMESTAMP DEFAULT current_timestamp,
    updated_on TIMESTAMP DEFAULT current_timestamp
);

ALTER TABLE book_location ADD FOREIGN KEY(book_id) REFERENCES book(book_id);
ALTER TABLE book_location ADD FOREIGN KEY(location_id) REFERENCES location(location_id);

