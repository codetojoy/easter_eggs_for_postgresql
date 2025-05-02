#!/bin/bash

set -e

./run-file.sh setup.sql $MY_DB

./run-file.sh incoming-v1.sql $MY_DB
./run-file.sh merge.sql $MY_DB

sleep 1
./run-file.sh incoming-v2.sql $MY_DB
./run-file.sh merge.sql $MY_DB

sleep 1
./run-file.sh incoming-v3.sql $MY_DB
./run-file.sh merge.sql $MY_DB

./run-file.sh list-table.sql $MY_DB
