#!/bin/bash

set -e 

psql -U postgres -d my-test-2300 -f account.sql
