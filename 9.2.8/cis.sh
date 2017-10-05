#!/bin/sh
#
# This file implements CIS Red Hat Enterprise Linux 7 Benchmark Level 2 - check 9.2.8 after first checking for compliance

echo =========
echo CIS 9.2.8
echo =========

echo -n 'Ensure no user dotfiles have group/other write permisions... '
OUTPUT=$(find `cat /etc/passwd | egrep -v "root|sync|halt|shutdown" | awk -F: '($7 != "/sbin/login" && $7) {print $6}' | sort | uniq | grep -v "^/$"` -name ".*" -perm /go+w)
if [ "x$OUTPUT" == "x" ]; then
	echo OK
else
	echo Failed - please review and fix the following files if possible. Dotfiles should not have group or other write permissions unless there is a very good reason.
	find `cat /etc/passwd | egrep -v "root|sync|halt|shutdown" | awk -F: '($7 != "/sbin/login" && $7) {print $6}' | sort | uniq | grep -v "^/$"` -name ".*" -perm /go+w
fi
