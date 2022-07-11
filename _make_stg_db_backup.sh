#!/bin/bash

ENV="stg"
PROJECT="horizont"
DB_CNF=".my.${ENV}-${PROJECT}-db.cnf"
DB_NAME="staging_db_name"
DUMP_DATE=`date +'%Y-%m-%d_%H-%M'`
DB_SQL_DUMP="${ENV}__${DB_NAME}__${DUMP_DATE}.sql"
TAR_DB_DUMP="${ENV}__${DB_NAME}__${DUMP_DATE}.sql.tar.bz2"


pwd

echo "Started ${DB_NAME} backup at `date`..."

if [[ ! -f ${DB_CNF} ]]
then
    echo "${DB_CNF} does not exist. DB backup has aborted."
    exit 1
fi

mysqldump --defaults-file=${DB_CNF} ${DB_NAME} > ${DB_SQL_DUMP}
ls -alh ${DB_SQL_DUMP}

echo "Making archive..."
tar cpjvf ${TAR_DB_DUMP} ${DB_SQL_DUMP}
ls -alh ${TAR_DB_DUMP}

rm -fv ${DB_SQL_DUMP}

echo "Finished ${DB_NAME} backup at `date`"
echo "DB backup file ${TAR_DB_DUMP}"
