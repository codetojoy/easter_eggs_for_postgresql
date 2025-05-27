
-- vid 620

CREATE TABLE vacuum_sandbox (
	ID integer
);

SELECT
pg_total_relation_size('vacuum_sandbox'),
pg_size_pretty(pg_total_relation_size('vacuum_sandbox'));

INSERT INTO vacuum_sandbox
SELECT * FROM generate_series(1,20000);