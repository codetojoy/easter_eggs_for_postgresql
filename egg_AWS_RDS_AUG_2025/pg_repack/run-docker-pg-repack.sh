#!/bin/bash

docker run -it --rm --name pg_repack \
-e PGPASSWORD=$DB_PASS -e "PGOPTIONS=" \
cherts/pg-repack:1.5.1 --host=$DB_HOST --port=$DB_PORT --username=$DB_USER --dbname=$DB_NAME --table=book \
--no-superuser-check --echo --jobs=2 
