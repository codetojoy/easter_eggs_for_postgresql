
MERGE INTO location loc
USING location_incoming li
ON loc.address = li.address AND loc.city = li.city AND loc.province = li.province
WHEN MATCHED THEN
  UPDATE set version = loc.version + 1, updated_on = default
WHEN NOT MATCHED THEN
  INSERT (address, city, province, version)
  VALUES (li.address, li.city, li.province, 1);

