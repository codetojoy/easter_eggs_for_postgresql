#!/bin/bash

set -e 

if [ -n "$1" ]; then
SQL_FILE=$1
else
  echo "usage: file database"
  exit -1
fi

stat $SQL_FILE > /dev/null

if [ -n "$2" ]; then
TARGET_DB=$2
else
  echo "usage: file database"
  exit -1
fi

psql -U postgres -f $SQL_FILE -d $TARGET_DB
