#!/bin/bash

#
# @author Shkodenko V. Taras (taras -at- shkodenko.com)
# @requires Frox FTP proxy, iptables firewall, Squid HTTP proxy
#
BK_DT="`date +'%Y%m%d%H%M'`"
FROX_CONF1="/etc/frox.conf"
FROX_CONF2="/etc/frox.conf-${BK_DT}.bak"
SQUID_CONF1="/etc/squid/squid.conf"
SQUID_CONF2="/etc/squid/squid.conf-${BK_DT}.bak"
IPTABLES_CONF1="/etc/sysconfig/iptables"
IPTABLES_CONF2="/etc/sysconfig/iptables-${BK_DT}.bak"
#

if [[ -z "${1}" ]];
then
	echo "Usage: $0 'Old IP' 'New IP'"
	exit 1
fi

echo "Old IP: ${1}"

if [[ -z "${2}" ]];
then
	echo "Usage: $0 'Old IP' 'New IP'"
	exit 1
fi

echo "New IP: ${2}"

if [ -f "${FROX_CONF1}" ]
then
	echo "Making FROX configuration file backup ${FROX_CONF1} to ${FROX_CONF2} ..."
	cp -fvp ${FROX_CONF1} ${FROX_CONF2}
	echo "Replacing old IP ${1} to new IP ${2} using command # sed -i "s/${1}/${2}/g" ${FROX_CONF1} ..."
	sed -i "s/${1}/${2}/g" ${FROX_CONF1}
	echo "View changes using command # diff -Nau ${FROX_CONF2} ${FROX_CONF1} ..."
	diff -Nau ${FROX_CONF2} ${FROX_CONF1}
	echo "Restarting frox service using command # /etc/init.d/frox restart ..."
	/etc/init.d/frox restart
else
	echo "${FROX_CONF1} not found."
fi

if [ -f "${SQUID_CONF1}" ]
then
	echo "Making SQUID configuration file backup ${SQUID_CONF1} to ${SQUID_CONF2} ..."
	cp -fvp ${SQUID_CONF1} ${SQUID_CONF2}
	echo "Replacing old IP ${1} to new IP ${2} using command # sed -i "s/${1}/${2}/g" ${SQUID_CONF1} ..."
	sed -i "s/${1}/${2}/g" ${SQUID_CONF1}
	echo "View changes using command # diff -Nau ${SQUID_CONF2} ${SQUID_CONF1} ..."
	diff -Nau ${SQUID_CONF2} ${SQUID_CONF1}
	echo "Running reload squid configuration using script # /root/scripts/squid_reconfigure.sh ..."
	/root/scripts/squid_reconfigure.sh
#
	if [ -f "${IPTABLES_CONF1}" ]
	then
		echo "Making IPTables configuration file backup ${IPTABLES_CONF1} to ${IPTABLES_CONF2} ..."
		cp -fvp ${IPTABLES_CONF1} ${IPTABLES_CONF2}
		echo "Replacing old IP ${1} to new IP ${2} using command # sed -i "s/${1}/${2}/g" ${IPTABLES_CONF1} ..."
		sed -i "s/${1}/${2}/g" ${IPTABLES_CONF1}
		echo "View changes using command # diff -Nau ${IPTABLES_CONF2} ${IPTABLES_CONF1} ..."
		diff -Nau ${IPTABLES_CONF2} ${IPTABLES_CONF1}
		echo "Running IPTables service restart using command # /sbin/service iptables restart ..."
		/sbin/service iptables restart
	fi
#
else
	echo "${SQUID_CONF1} not found."
fi
