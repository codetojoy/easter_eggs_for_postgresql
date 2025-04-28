#!/bin/bash

set -e 

if [ -n "$1" ]; then
TARGET_DB=$1
else
  echo "usage: database"
  exit -1
fi

psql -U postgres -c "DROP DATABASE \"${TARGET_DB}\";"
