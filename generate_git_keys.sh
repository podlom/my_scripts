#!/bin/bash

#
# @author Shkodenko V. Taras (taras -at- shkodenko.com)
# @requires ssh-keygen, zip
#

NAME="$1"


function __usage() {
	echo "Script usage: $0 'Username' #<--- string before @shkodenko.com"
}


function __generate_keys() {
  local NAME=$1
  local DIR="/home/taras/Project/git-projects-dir/get-server-1/tmp/.ssh"
  local DIR2="/home/taras/Project/git-projects-dir/get-server-1/tmp/"
  local DT="`date +'%Y-%m-%d'`"

  if [ -z "${NAME}" ]; then
		__usage
		return 1;
	else
		local ZIP="${DIR2}${NAME}-git-keys-${DT}.zip"
		echo "Generate SSH keys for user ${NAME}..."

		if [ ! -d "${DIR}" ]
		then
			mkdir -pv ${DIR}
			chmod -fv 700 ${DIR}
		else
			rm -Rfv "${DIR}/*"
		fi

		/usr/bin/ssh-keygen -t rsa -f "${DIR}/id_rsa" -C "${NAME}@shkodenko.com"

		echo "Private key ${DIR}/id_rsa is:"
		more "${DIR}/id_rsa"
		echo ""
		echo "Public key ${DIR}/id_rsa.pub is:"
		more "${DIR}/id_rsa.pub"
		echo ""

		if [ ! -d "${DIR2}" ]
		then
			mkdir -pv ${DIR2}
			chmod -fv 755 ${DIR2}
		else
			rm -Rfv "${DIR2}/*"
		fi

		cd ${DIR2}

		/usr/bin/zip -r "${ZIP}" ./.ssh
		
		echo "Created zip archive with .ssh folder:"
		ls -alh "${ZIP}"

		echo "Remove useless files from directory ${DIR}..."
		rm -Rfv ${DIR}

		__show_email_text "${NAME}" "${NAME}-git-keys-${DT}.zip"

  fi
}


function __show_email_text() {
	local NAME=$1
	local ZIPF=$2
	local DELI="-------------------------8<------------8<------------8<-------------------------"
	local EMLM="Subject: Your SSH Keys


${NAME}, 
your SSH keys are in attached zip archive.
These keys will be used to authorize you in all git repositories.

To install them use commands:
\$ cd \$HOME
\$ unzip ${ZIPF}


"

	echo ""
	echo "${DELI}"
	echo ""
	echo "${EMLM}"
	echo ""
	echo "${DELI}"
	echo ""
}


if [ ! -z "${NAME}" ]; then
	__generate_keys ${NAME}
else
	__usage
fi
