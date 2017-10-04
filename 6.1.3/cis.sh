#!/bin/sh
#
# This file implements CIS Red Hat Enterprise Linux 7 Benchmark Level 2 - check 6.1.3 after first checking for compliance

echo =========
echo CIS 6.1.3
echo =========

echo -n 'Ensure /etc/anacrontab is owned by root... '
OUTPUT=$(stat -L -c "%u %g" /etc/anacrontab)
if [ "x$OUTPUT" == "x0 0" ]; then
	echo OK
else
	echo Failed - attempting to fix...
	chown 0:0 /etc/anacrontab
fi

echo -n 'Ensure /etc/anacrontab inaccessible by group/other... '
OUTPUT=$(ui=($(echo 0077 -n | fold -w1));sys=($(stat -L --format="%a" /etc/anacrontab | awk '{printf "%04d\n", $0;}' | fold -w1));for (( i=0; i<4; i++ )); do echo -n $(( ${ui[$i]} & ${sys[$i]})); done)
if [ "x$OUTPUT" == "x0000" ]; then
        echo OK
else
        echo Failed - attempting to fix...
        chmod 0600 /etc/anacrontab
fi
