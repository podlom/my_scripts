#!/bin/bash

BACKUP_STD=32
BACKUP_NUM=`date +"%u"`
BACKUP_DIR="/root/backups/_mysql_databases${BACKUP_NUM}"
BACKUP_DATE=`date +"%Y-%m-%d-%H-%M"`

echo "Backup MySQL databases script has started"
date

if [ ! -d "${BACKUP_DIR}" ]
then
    echo "Directory ${BACKUP_DIR} does not exists!"
    mkdir -pv ${BACKUP_DIR}
fi

echo "Remove database backup files oder than ${BACKUP_STD} days..."
find ${BACKUP_DIR} -type f -iname "*.sql*" -mtime +${BACKUP_STD} -exec rm -fv {} \;

cd ${BACKUP_DIR}

#
# With ~/.my.cnf root administrator in
DBS=`mysql -h localhost -e "show databases;" | grep -v "Database"`
#
for db in ${DBS}; do
    echo "Working with database $db ..."
    SQL_BACKUP="${db}_${BACKUP_DATE}.sql"
    if [ -f ${SQL_BACKUP} ]
    then
        echo "Delete useless copy ${SQL_BACKUP}"
        rm -fv ${SQL_BACKUP}
    fi
    SQL_GZ_BACKUP="${SQL_BACKUP}.gz"
    if [ -f ${SQL_GZ_BACKUP} ]
    then
        echo "Delete useless copy ${SQL_GZ_BACKUP}"
        rm -fv ${SQL_GZ_BACKUP}
    fi
    # With ~/.my.cnf root administrator in
    echo "Running mysqldump -h localhost --routines ${db} > ${SQL_BACKUP} ..."
    mysqldump -h localhost --routines ${db} > "${SQL_BACKUP}"
    #
    echo "Running gzip -6 ${SQL_BACKUP} ..."
    gzip -6 ${SQL_BACKUP}
    # rm -fv ${SQL_BACKUP}
done
echo "Backup MySQL databases script has finished"
date
