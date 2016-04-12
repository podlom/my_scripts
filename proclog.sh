#!/bin/bash

#
# @author Shkodenko V. Taras (taras -at- shkodenko.com)
# @requires top, df, iostat, vmstat, ps, cat, free, uptime, who, w, netstat, wget
#

# Change the DIR variable to change the directory that the log files are stored in
DIR="/root/proclog"
if [ ! -d "$DIR" ]
then
	mkdir -p $DIR
fi

LOGFILE="$DIR/server-diag.`date +%Y%m%d-%H%M`.log"

# Clean up log files older than N days
find $DIR/ -type f -mtime +31 -exec rm -f {} \;

HEADERLEFT="--------========[ Output of '"
HEADERRIGHT="' ]========--------"

# The command stack: you can customize what diagnostic commands are
# run by adding them to this array.
cmdstack[1]="top -bn1"
cmdstack[2]="df -h"
cmdstack[3]="iostat -dh"
cmdstack[4]="vmstat 1 2"
cmdstack[5]="ps fhauxwww"
cmdstack[6]="cat /proc/meminfo"
cmdstack[7]="free -m"
cmdstack[8]="uptime"
cmdstack[9]="who"
cmdstack[10]="w"
cmdstack[11]="netstat -pant"
cmdstack[12]="wget -O - -q -t 1 http://localhost/server-status"
cmdstack[13]="/root/scripts/check-http-80.pl"
cmdstack[14]="/root/scripts/mysql_process_list.sh"

for i in "${cmdstack[@]}"
do
  CMDNAME=`echo $i | awk '{ print $1}'`
  echo "$HEADERLEFT $i $HEADERRIGHT" >> $LOGFILE
  if [ -x `which $CMDNAME` ]; then
		$i >> $LOGFILE
  else
		echo "'$CMDNAME' is not installed or is not present in the system path" >> $LOGFILE
  fi
  echo >> $LOGFILE
done
