#!/bin/bash

set -e

./run-file.sh setup.sql $MY_DB

echo "populating ..."
groovy Populate.groovy 

./run-file.sh table-size.sql $MY_DB
