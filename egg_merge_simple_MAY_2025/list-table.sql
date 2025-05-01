
SELECT 
station_id,
version,
a,
b,
to_char(created_on, 'YYYY-MM-DD HH24:MI:SS') as created_on,
to_char(updated_on, 'YYYY-MM-DD HH24:MI:SS') as updated_on	 
FROM station_data 
ORDER BY version desc, station_id asc;
