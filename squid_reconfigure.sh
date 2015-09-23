#!/bin/bash

#
# @author Shkodenko V. Taras (taras -at- shkodenko.com)
# @requires Squid HTTP proxy
#

echo "SQUID check..."
/usr/sbin/squid -k check
RETVAL=$?
if [ $RETVAL -eq 0 ]; then
	# echo $RETVAL
	echo "SQUID reconfigure..."
	/usr/sbin/squid -k reconfigure
	# echo $?
	echo "Reload SQUID service..."
	/sbin/service squid reload
	# echo $?
fi
