#!/bin/bash

set -e

echo "deleting ..."
./run-file.sh delete-rows.sql $MY_DB

echo "vacuuming ..."
./run-file.sh vacuum-table.sql $MY_DB
# ./run-file.sh table-size.sql $MY_DB

echo "tuple info:"
./run-file.sh tuple-info.sql $MY_DB 

