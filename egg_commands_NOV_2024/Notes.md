
```
select * from pg_stat_user_tables;
select pg_size_pretty(pg_relation_size('computer'))
select count(*) from pg_settings;
select * from pg_settings order by name;
```

```
create table test_index (id serial, name text);
insert into test_index (name) select 'bob' from generate_series(1,1000000);
```
