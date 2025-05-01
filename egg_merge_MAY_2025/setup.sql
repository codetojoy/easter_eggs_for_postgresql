
-- https://www.crunchydata.com/blog/a-look-at-postgres-15-merge-command-with-examples

DROP TABLE IF EXISTS station_data_incoming;
DROP TABLE IF EXISTS station_data;

CREATE TABLE station_data_incoming (
    station_id   integer,
    a            integer,
    b            integer
);

CREATE TABLE station_data (
    station_id   integer   primary key,
    a integer,
    b integer,
    version integer,
    created_on    TIMESTAMP DEFAULT current_timestamp,
    updated_on    TIMESTAMP DEFAULT current_timestamp
);
