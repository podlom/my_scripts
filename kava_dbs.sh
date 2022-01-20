#!/bin/bash

BK_DT="`date +'%Y-%m-%d_%H-%M'`"
DBS=('coffee-ucc_1' 'coffee-ucc_pan')

pwd
ls -alh
echo "Backup has started at `date`..."

for db in ${DBS[@]}
do
        echo $db
        SQL_DUMP="${db}__${BK_DT}.sql"
        mysqldump $db > $SQL_DUMP
        ls -alh $SQL_DUMP
        TAR_DUMP="${SQL_DUMP}.tar.bz2"
        tar cpjvf $TAR_DUMP $SQL_DUMP
        ls -alh $TAR_DUMP
        rm -fv $SQL_DUMP
done

find . -type f -iname '*.tar.bz2' -mtime +7 -delete

echo "Backup has finished at `date`..."
