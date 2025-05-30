#!/bin/bash

set -e

./run-file.sh setup.sql $MY_DB

./run-file.sh incoming-iter1.sql $MY_DB
./run-file.sh merge.sql $MY_DB
groovy Iter1_Assert.groovy 

./run-file.sh incoming-iter2.sql $MY_DB
./run-file.sh merge.sql $MY_DB
groovy Iter2_Assert.groovy 

# sleep 1
# ./run-file.sh incoming-iter3.sql $MY_DB
# ./run-file.sh merge.sql $MY_DB

./run-file.sh list-table.sql $MY_DB
