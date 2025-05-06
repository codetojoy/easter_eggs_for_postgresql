
DROP TABLE IF EXISTS book;

CREATE TABLE book (
    book_id  SERIAL PRIMARY KEY,
    title VARCHAR(255),
    author VARCHAR(255),
    excerpt TEXT,
    deleted BOOLEAN DEFAULT false,
    created_on TIMESTAMP DEFAULT current_timestamp,
    updated_on TIMESTAMP DEFAULT current_timestamp
);

CREATE EXTENSION IF NOT EXISTS pgstattuple;
