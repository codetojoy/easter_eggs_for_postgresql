
```
select * from pg_stat_user_tables;
select pg_size_pretty(pg_relation_size('computer'))
select count(*) from pg_settings;
select * from pg_settings order by name;
```

```
create table test_index (id serial, name text);
insert into test_index (name) select 'bob' from generate_series(1,1000000);
insert into test_index (name) select 'alice' from generate_series(1,1000000);

explain analyze select * from test_index where id = 2;

create index idx_test_index_id on test_index (id);
```

bitmap scan example:
```
create table test_index2 (id serial, value integer);
insert into test_index2 (value) select trunc(random()*10) from generate_series(1,1000000);
create index idx_test_index2_value on test_index2 (value);

explain analyze select count(*) from test_index2 where value = 1;
select relname, relpages, reltuples from pg_class where relname = 'test_index2';
```

index on FK:
```
create table orders (order_no serial primary key, order_date date);
create table items (item_no serial NOT NULL, order_no integer,
                    product_name varchar, description varchar, created_on timestamp,
    constraint fk_items foreign key (order_no)
    references orders (order_no)
    match simple on update cascade on delete cascade);

with order_rows as (
    insert into orders (order_no, order_date)
        select generate_series(1, 100000), now()
    returning order_no)
insert into items (item_no, order_no, product_name, description, created_on)
    select generate_series(1,4) item_no, order_no, 'p', repeat('desc', 20), now()
    from order_rows;

create index idx_ord on items(order_no);
```
