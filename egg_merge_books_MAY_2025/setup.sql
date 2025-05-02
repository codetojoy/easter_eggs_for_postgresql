
DROP TABLE IF EXISTS location_incoming;
DROP TABLE IF EXISTS location;

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
