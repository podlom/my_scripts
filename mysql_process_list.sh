#!/bin/bash

mysql --defaults-file=/root/.my.cnf mysql -e 'show full processlist;'
