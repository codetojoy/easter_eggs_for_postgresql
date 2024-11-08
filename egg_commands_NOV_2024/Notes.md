
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

```
create table test_index2 (id serial, value integer);
insert into test_index2 (value) select trunc(random()*10) from generate_series(1,1000000);
create index idx_test_index2_value on test_index2 (value);

explain analyze select count(*) from test_index2 where value = 1;
select relname, relpages, reltuples from pg_class where relname = 'test_index2';

```
