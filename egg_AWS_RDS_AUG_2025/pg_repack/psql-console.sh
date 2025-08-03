#!/bin/bash

set -e 

psql --host $DB_HOST --port $DB_PORT --username $DB_USER --dbname $DB_NAME 

