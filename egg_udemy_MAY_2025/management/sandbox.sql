
-- vid 620

CREATE TABLE vacuum_sandbox (
	ID integer
);

SELECT
pg_total_relation_size('vacuum_sandbox'),
pg_size_pretty(pg_total_relation_size('vacuum_sandbox'));

INSERT INTO vacuum_sandbox
SELECT * FROM generate_series(1,100000);

SELECT COUNT(*) FROM vacuum_sandbox;

-- before size: 4280 K
-- after size: 8528 K
UPDATE vacuum_sandbox set id = id + 1;

-- vid 621
-- auto vacuum

SELECT relname, last_vacuum, last_autovacuum, 
vacuum_count, autovacuum_count 
last_analyze, last_autoanalyze
FROM pg_stat_all_tables
WHERE relname = 'vacuum_sandbox'
