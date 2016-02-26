#!/usr/bin/env bash

# TODO: Select working mirror near to you from http://php.net/get/php_enhanced_en.chm/from/a/mirror

DOC_DATE="$(date +'%Y-%m-%d_%H-%M')"
DOC_NAME="php_enhanced_en_${DOC_DATE}.chm"
MIRROR_URL="http://ua2.php.net/get/php_enhanced_en.chm/from/this/mirror"
WHERE_TO_DOWNLOAD="/home/taras/Downloads/"

echo "Get new PHP doc has started at `date`"
wget -O ${WHERE_TO_DOWNLOAD}${DOC_NAME} ${MIRROR_URL}
echo "Get new PHP doc has finished at `date`"
