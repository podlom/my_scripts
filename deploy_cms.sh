#!/bin/bash

# Example deploy command
# scp -P 10111 common/models/User.php taras@ssh-host-shkodenko.com:/home/taras/public_html/cms/common/models/User.php

#
# To test file existence, the parameter can be any one of the following:
# 
# -e: Returns true value, if file exists
# -f: Return true value, if file exists and regular file
# -r: Return true value, if file exists and is readable
# -w: Return true value, if file exists and is writable
# -x: Return true value, if file exists and is executable
# -d: Return true value, if exists and is a directory
#

SAND_HTDOCS="/home/taras/sand_htdocs/cms/"
FILE=$1

if [ -z "${FILE}" ];
then
	echo "Script usage: $0 file_to_deploy"
	exit;
fi

if [ -f "${FILE}" ];
then
    echo "Old file ${SAND_HTDOCS}${FILE} information:"
    ls -alh ${SAND_HTDOCS}${FILE}
    sha1sum -b ${SAND_HTDOCS}${FILE}
    #
    echo "Deploying file ${SAND_HTDOCS}${FILE}..."
    cp -v ${FILE} ${SAND_HTDOCS}${FILE}
    #
    echo "New file ${SAND_HTDOCS}${FILE} information:"
	ls -alh ${SAND_HTDOCS}${FILE}
    sha1sum -b ${SAND_HTDOCS}${FILE}
else
    echo "Error: file ${FILE} does not exist"
fi
