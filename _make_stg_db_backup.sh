#!/bin/bash

DB_NAME="horizont_staging"
DUMP_DATE=`date +'%Y-%m-%d_%H-%M'`
DB_SQL_DUMP="${DB_NAME}__${DUMP_DATE}.sql"
TAR_DB_DUMP="${DB_NAME}__${DUMP_DATE}.sql.tar.bz2"

echo "Started ${DB_NAME} backup at `date`..."

mysqldump --defaults-file=.my.stg-horizont-db.cnf ${DB_NAME} > ${DB_SQL_DUMP}
ls -alh ${DB_SQL_DUMP}

echo "Making archive..."
tar cpjvf ${TAR_DB_DUMP} ${DB_SQL_DUMP}
ls -alh ${TAR_DB_DUMP}

rm -fv ${DB_SQL_DUMP}

echo "Finished ${DB_NAME} backup at `date`"
echo "DB backup file ${TAR_DB_DUMP}"
