
WITH measures AS (
  select *
  from generate_series(1,5)
)
insert into station_data_new (
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

MERGE INTO station_data_actual sda
USING station_data_new sdn
ON sda.station_id = sdn.station_id
WHEN MATCHED THEN
  UPDATE set a = sdn.a, b = sdn.b, updated = default
WHEN NOT MATCHED THEN
  INSERT (station_id, a, b)
  VALUES (sdn.station_id, sdn.a, sdn.b);
