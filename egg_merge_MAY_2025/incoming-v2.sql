
TRUNCATE TABLE station_data_incoming;

WITH measures AS (
  select *
  from generate_series(1,4)
)
insert into station_data_incoming (
    station_id
  , a
  , b
)
SELECT
    generate_series
  , round(random()*100+1)
  , round(random()*100+1)
FROM
  measures;
