
DROP TABLE IF EXISTS location_incoming;
DROP TABLE IF EXISTS book_incoming;
DROP TABLE IF EXISTS book_location_incoming;

DROP TABLE IF EXISTS book_location;
DROP TABLE IF EXISTS book;
DROP TABLE IF EXISTS location;

CREATE TABLE location_incoming (
    address VARCHAR(255) NOT NULL,
    city VARCHAR(255) NOT NULL,
    province VARCHAR(255) NOT NULL
);

CREATE TABLE location (
    location_id  SERIAL PRIMARY KEY,
    address VARCHAR(255) NOT NULL,
    city VARCHAR(255) NOT NULL,
    province VARCHAR(255) NOT NULL,
    version INTEGER DEFAULT 1,
    created_on TIMESTAMP DEFAULT current_timestamp,
    updated_on TIMESTAMP DEFAULT current_timestamp
);

CREATE TABLE book_incoming (
    title VARCHAR(255) NOT NULL,
    author VARCHAR(255) NOT NULL
);

CREATE TABLE book (
    book_id  SERIAL PRIMARY KEY,
    title VARCHAR(255),
    author VARCHAR(255),
    version INTEGER DEFAULT 1,
    created_on TIMESTAMP DEFAULT current_timestamp,
    updated_on TIMESTAMP DEFAULT current_timestamp
);

CREATE TABLE book_location_incoming (
    title VARCHAR(255) NOT NULL,
    author VARCHAR(255) NOT NULL,
    address VARCHAR(255) NOT NULL,
    city VARCHAR(255) NOT NULL,
    province VARCHAR(255) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE,
    book_id  INTEGER,
    location_id INTEGER
);

ALTER TABLE book_location_incoming ADD FOREIGN KEY(book_id) REFERENCES book(book_id);
ALTER TABLE book_location_incoming ADD FOREIGN KEY(location_id) REFERENCES location(location_id);

CREATE TABLE book_location (
    book_location_id  SERIAL PRIMARY KEY,
    book_id  INTEGER NOT NULL,
    location_id INTEGER NOT NULL,
    version INTEGER NOT NULL DEFAULT 1,
    start_date DATE NOT NULL,
    end_date DATE,
    created_on TIMESTAMP NOT NULL DEFAULT current_timestamp,
    updated_on TIMESTAMP NOT NULL DEFAULT current_timestamp
);

ALTER TABLE book_location ADD FOREIGN KEY(book_id) REFERENCES book(book_id);
ALTER TABLE book_location ADD FOREIGN KEY(location_id) REFERENCES location(location_id);

