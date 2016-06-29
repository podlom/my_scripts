#!/bin/bash

SAND_HTDOCS_DIR="/home/taras/sand_htdocs"

if [ "$(ls -A $SAND_HTDOCS_DIR)" ]; then
    echo "Directory ${SAND_HTDOCS_DIR} is already mounted:"
    echo "`mount | grep -v grep | grep sshfs`"
else
    sshfs taras@ssh-host-shkodenko.com:/home/taras/public_html/ ${SAND_HTDOCS_DIR}
fi
