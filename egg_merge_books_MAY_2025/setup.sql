
DROP TABLE IF EXISTS location_incoming;
DROP TABLE IF EXISTS location;

DROP TABLE IF EXISTS book_incoming;
DROP TABLE IF EXISTS book;

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
    version INTEGER,
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
    version INTEGER,
    created_on TIMESTAMP DEFAULT current_timestamp,
    updated_on TIMESTAMP DEFAULT current_timestamp
);
