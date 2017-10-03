#!/bin/sh
#
# This file implements CIS Red Hat Enterprise Linux 7 Benchmark Level 2 - check 5.1.4 after first checking for compliance

echo =========
echo CIS 5.1.4
echo =========

echo -n Ensure all rsyslog log files are owned by root...
OUTPUT=$(find `awk '/^ *[^#$]/ { print $2 }' /etc/rsyslog.conf | egrep -o "/.*"` ! -user root)
if [ "x$OUTPUT" == "x" ]; then
	echo OK
else
	echo Failed - attempting to fix
	find `awk '/^ *[^#$]/ { print $2 }' /etc/rsyslog.conf | egrep -o "/.*"` ! -user root -exec chown root '{}' \;
fi

echo -n Ensure all rsyslog log files are not accessible to other...
OUTPUT=$(find `awk '/^ *[^#$]/ { print $2 }' /etc/rsyslog.conf | egrep -o "/.*"` -perm /o+rwx)
if [ "x$OUTPUT" == "x" ]; then
        echo OK
else
        echo Failed - attempting to fix
	find `awk '/^ *[^#$]/ { print $2 }' /etc/rsyslog.conf | egrep -o "/.*"` -perm /o+rwx -exec chmod o-rwx '{}' \;
fi

echo -n Ensure all rsyslog log files are not writable or executable by group...
OUTPUT=$(find `awk '/^ *[^#$]/ { print $2 }' /etc/rsyslog.conf | egrep -o "/.*"` -perm /g+wx)
if [ "x$OUTPUT" == "x" ]; then
        echo OK
else
        echo Failed - attempting to fix
	find `awk '/^ *[^#$]/ { print $2 }' /etc/rsyslog.conf | egrep -o "/.*"` -perm /g+wx -exec chmod g-wx '{}' \;
fi
