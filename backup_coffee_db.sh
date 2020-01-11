#!/bin/bash

BK_DT="`date +'%Y-%m-%d_%H-%M'`"
DB_NAME="coffeeuc_db1"
DUMP1_SQL_FILE="${DB_NAME}_1_no_cache__${BK_DT}.sql"
DUMP2_SQL_FILE="${DB_NAME}_2_cache_no-data__${BK_DT}.sql"
TAR_BZ2_FILE="${DB_NAME}__${BK_DT}.tar.bz2"

cd /home/coffeuc/backups
pwd
ls -alh *.sql
echo "Backup has started at `date`..."

#
# MySQL dump #1 no cache tables...
#
mysqldump --defaults-file=.coffee.my.cnf ${DB_NAME} --ignore-table=${DB_NAME}.cache --ignore-table=${DB_NAME}.cache_admin_menu --ignore-table=${DB_NAME}.cache_block --ignore-table=${DB_NAME}.cache_bootstrap --ignore-table=${DB_NAME}.cache_commerce_shipping_rates --ignore-table=${DB_NAME}.cache_field --ignore-table=${DB_NAME}.cache_filter --ignore-table=${DB_NAME}.cache_form --ignore-table=${DB_NAME}.cache_image --ignore-table=${DB_NAME}.cache_menu --ignore-table=${DB_NAME}.cache_metatag --ignore-table=${DB_NAME}.cache_page --ignore-table=${DB_NAME}.cache_path --ignore-table=${DB_NAME}.cache_path_breadcrumbs --ignore-table=${DB_NAME}.cache_rules --ignore-table=${DB_NAME}.cache_session_cache --ignore-table=${DB_NAME}.cache_token --ignore-table=${DB_NAME}.cache_update --ignore-table=${DB_NAME}.cache_variable --ignore-table=${DB_NAME}.cache_views --ignore-table=${DB_NAME}.cache_views_data --ignore-table=${DB_NAME}.ctools_css_cache --ignore-table=${DB_NAME}.ctools_object_cache > ${DUMP1_SQL_FILE}

#
# MySQL dump #2 only cache tables structure...
#
mysqldump --defaults-file=.coffee.my.cnf --no-data ${DB_NAME}  cache cache_admin_menu cache_block cache_bootstrap cache_commerce_shipping_rates cache_field cache_filter cache_form cache_image cache_menu cache_metatag cache_page cache_path cache_path_breadcrumbs cache_rules cache_session_cache cache_token cache_update cache_variable cache_views cache_views_data ctools_css_cache ctools_object_cache > ${DUMP2_SQL_FILE}

echo "Made two SQL dump files: "
ls -alh ${DUMP1_SQL_FILE} ${DUMP2_SQL_FILE}

#
# Make tar.bz2 archive
#
tar cpjvf ${TAR_BZ2_FILE} ${DUMP1_SQL_FILE} ${DUMP2_SQL_FILE}

echo "Archive is ready: "
ls -alh ${TAR_BZ2_FILE}

echo "Remove SQL files: "
rm -fv ${DUMP1_SQL_FILE} ${DUMP2_SQL_FILE}

echo "Backup has finished at `date`..."
