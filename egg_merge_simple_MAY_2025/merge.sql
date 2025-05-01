
MERGE INTO station_data sd
USING station_data_incoming sdi
ON sd.station_id = sdi.station_id
WHEN MATCHED THEN
  UPDATE set a = sdi.a, b = sdi.b, version = sd.version + 1, updated_on = default
WHEN NOT MATCHED THEN
  INSERT (station_id, a, b, version)
  VALUES (sdi.station_id, sdi.a, sdi.b, 1);

