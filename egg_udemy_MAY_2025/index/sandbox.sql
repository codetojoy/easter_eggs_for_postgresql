
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

