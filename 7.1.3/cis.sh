#!/bin/sh
#
# This file implements CIS Red Hat Enterprise Linux 7 Benchmark Level 2 - check 7.1.3 after first checking for compliance

echo =========
echo CIS 7.1.3
echo =========

echo -n 'Ensure users are warned at least 7 days in advance of expiration... '
OUTPUT=$(/bin/awk '$1 == "PASS_WARN_AGE" && $2 >= 7 {print $0}' /etc/login.defs)
if [ "x$OUTPUT" != "x" ]; then
	echo OK
else
	echo Failed - attempting to fix automatically...
	sed -i -r 's/^ *PASS_WARN_AGE\s*[0-9]+(.*)?$/PASS_WARN_AGE   7\1/g' /etc/login.defs
fi

echo -n 'Ensure usernames pattern match .* have shadow parameter exp_warn greater than or equal 7 (int)... '
OUTPUT=$(cat /etc/shadow | /bin/awk -F: '($6 < 7 ) { print $1 $6 " password Age must be at least 7 days"}')
if [ "x$OUTPUT" == "x" ]; then
	echo OK
else
	echo Failed - attempting to fix automatically...
	for user in $(cat /etc/shadow | /bin/awk -F: '($6 < 7 ) { print $1 }')
	do
		chage -W 7 $user
	done
fi
