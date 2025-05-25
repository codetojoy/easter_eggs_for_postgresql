
-- vid 249
-- northwind database

CREATE INDEX IF NOT EXISTS idx_orders_order_date ON orders (order_date);

SELECT COUNT(*) FROM orders;

-- list
SELECT * from pg_indexes 
WHERE schemaname = 'public' and indexname not like 'pk_%'
ORDER BY tablename;

-- size
SELECT pg_size_pretty(pg_relation_size('idx_orders_order_date'::regclass)) as index_size

-- list counts
SELECT * FROM pg_stat_all_indexes
where schemaname = 'public'
order by relname, indexrelname;

select * from orders limit 10;
select * from orders where order_date > timestamp '1996-07-03 00:00:00'

-- nodes
SELECT * FROM pg_am;

-- seq scan
EXPLAIN SELECT * FROM orders;

-- index scan
EXPLAIN SELECT * FROM orders where order_id = 1;

-- index-only scan
EXPLAIN SELECT order_id FROM orders where order_id = 1;

-- bitmap scan
-- no example

-- join nodes
SHOW work_mem;

-- hash join 1
EXPLAIN SELECT * FROM orders NATURAL JOIN customers;

-- hash join 2
EXPLAIN SELECT * FROM orders ord
JOIN customers c on c.customer_id = ord.customer_id;

-- example query plan
EXPLAIN SELECT company_name FROM suppliers
ORDER BY company_name;

-- example 2
EXPLAIN (FORMAT JSON) SELECT company_name FROM suppliers
ORDER BY company_name;


-- vid 269

DROP TABLE IF EXISTS my_big_data ;
-- no index
CREATE TABLE IF NOT EXISTS my_big_data (id serial, name text);

INSERT INTO my_big_data (name)
SELECT 'Mozart-' || x FROM generate_series(1,2000000) as x;

INSERT INTO my_big_data (name)
SELECT 'Chopin-' || x FROM generate_series(1,2000000) as x;

SELECT * from my_big_data where id = 12345;
EXPLAIN SELECT * from my_big_data where id = 12345;

SELECT COUNT(*) FROM my_big_data;
EXPLAIN INSERT INTO my_big_data (name)
SELECT 'Brahms-' || x FROM generate_series(1,200) as x;

show max_parallel_workers_per_gather;

-- num blocks
select pg_relation_size('my_big_data') / 8192.0;
show seq_page_cost;
show cpu_tuple_cost;
show cpu_operator_cost;

-- vid 270

select pg_size_pretty(pg_indexes_size('my_big_data'));
select pg_size_pretty(pg_relation_size('my_big_data'));

CREATE INDEX IF NOT EXISTS idx_my_big_data_id on my_big_data(id);

show max_parallel_maintenance_workers;

EXPLAIN ANALYZE SELECT * from my_big_data where id = 12345;
EXPLAIN ANALYZE SELECT id from my_big_data where id = 12345;

-- vid 271

EXPLAIN SELECT min(id) from my_big_data;
EXPLAIN SELECT min(name) from my_big_data;

-- vid 272
-- cost: 16.85
EXPLAIN SELECT * FROM my_big_data WHERE id = 20 or id = 40;
-- cost: 12.89
EXPLAIN SELECT * FROM my_big_data WHERE id IN (20,40);
-- cost: 8.89
EXPLAIN SELECT id FROM my_big_data WHERE id IN (20,40);

-- vid 274

EXPLAIN (analyze true, buffers true, timing true)
SELECT * FROM my_big_data where id < 1000;

-- vid 276

SELECT * FROM my_big_data limit 10;
SELECT pg_size_pretty(pg_indexes_size('my_big_data'))
DROP INDEX IF EXISTS idx_my_big_data_name;
CREATE INDEX IF NOT EXISTS idx_p_my_big_data_name ON my_big_data(name)
WHERE name NOT LIKE '%-1%' 
AND name NOT LIKE '%-2%'
AND name NOT LIKE '%-3%'
AND name NOT LIKE '%-4%'
AND name NOT LIKE '%-5%'
AND name NOT LIKE '%-6%'
AND name NOT LIKE '%-7%'
;
EXPLAIN ANALYZE SELECT * from my_big_data where name = 'Mozart-1180';

-- vid 278
-- valid index
SELECT oid, relname, relpages, reltuples,
i.indisunique, i.indisclustered, i.indisvalid,
pg_catalog.pg_get_indexdef(i.indexrelid, 0, true)
FROM pg_class c
JOIN pg_index i on i.indrelid = c.oid
WHERE c.relname = 'my_big_data';
