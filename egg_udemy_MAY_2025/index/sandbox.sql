
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