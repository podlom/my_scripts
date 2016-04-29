#!/bin/bash

BACKUP_NUM=`date +"%u"`
BACKUP_DIR="/root/backups/_mysql_databases${BACKUP_NUM}"

echo "Backup MySQL databases script has started"
date

if [ ! -d "${BACKUP_DIR}" ]
then
  echo "Directory ${BACKUP_DIR} does not exists!"
  mkdir -pv ${BACKUP_DIR}
fi

echo "Remove old databases..."
find ${BACKUP_DIR} -type f -iname "*.sql*" -mtime +28 -exec rm -fv {} \;

cd ${BACKUP_DIR}

DB_USER="admin"
DB_PASS=`cat /etc/psa/.psa.shadow`
DBS=`mysql -h localhost -u ${DB_USER} -p${DB_PASS} -e "show databases;" | grep -v "Database"`
for db in ${DBS}; do
    echo "Working with database $db ..."
    if [ -f ${db}.sql ]
    then
        echo "Delete useless copy ${db}.sql"
        rm -fv "${db}.sql"
    fi
    if [ -f ${db}.sql.gz ]
    then
        echo "Delete useless copy ${db}.sql.gz"
        rm -fv "${db}.sql.gz"
    fi
    echo "Running mysqldump -h localhost -u ${DB_USER} -p... ${db} > ${db}.sql ..."
    mysqldump -h localhost -u ${DB_USER} -p${DB_PASS} ${db} > "${db}.sql"
    echo "Compressing SQL dump file. Running gzip -v -6 ${db}.sql ..."
    gzip -v -6 "${db}.sql"
    # rm -fv "${db}.sql"
done
echo "Backup MySQL databases script has finished"
date
