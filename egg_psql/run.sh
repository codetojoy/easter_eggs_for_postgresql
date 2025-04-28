#!/bin/bash

psql -U postgres -d my-sandbox -c "SELECT * FROM account;"
