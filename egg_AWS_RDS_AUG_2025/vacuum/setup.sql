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

-- what are installed?
-- SELECT oid, extname, extversion FROM pg_extension;

-- what are available?
-- SELECT name, default_version, installed_version FROM pg_available_extensions ORDER BY name;

CREATE EXTENSION IF NOT EXISTS pgstattuple;
CREATE EXTENSION IF NOT EXISTS pg_repack;

