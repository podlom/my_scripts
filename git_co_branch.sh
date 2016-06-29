#!/bin/bash

BRANCH_NAME="$1"
LOCAL_WORK_TREE="/home/taras/MyProjects/ProjectN/cms"
SAND_WORK_TREE="/home/projectn/cms"
REMOTE_USER="taras.shkod"
REMOTE_HOST="ssh-host-shkodenko.com"

if [ ! -v BRANCH_NAME ]
then
    echo "Branch name is unset"
elif [ -z "${BRANCH_NAME}" ]
then
    echo "Usage: $0 'branch_name'"
else
    echo "Checking out branch ${BRANCH_NAME}"
    #
    echo ""
    echo "Working with local work tree..."
    echo "------ [ Start of local PC output "
    cd ${LOCAL_WORK_TREE}
    echo ' changed directory to '
    pwd
    git status
    git checkout ${BRANCH_NAME}
    git status
    echo "------ End of local PC output ] "
    #
    echo ""
    echo ""
    echo "Working with remote sand server..."
    echo "------ [ Start of Sand server output "
    ssh ${REMOTE_USER}@${REMOTE_HOST} "cd ${SAND_WORK_TREE} && echo ' changed directory to ' && pwd && git status && git checkout ${BRANCH_NAME} && git status"
    echo "------ End of Sand server output ] "
    echo ""
    echo "Note: do not forget to run % git pull % on both copies manually"
    echo ""
fi
