#!/bin/sh
#
# This file implements CIS Red Hat Enterprise Linux 7 Benchmark Level 2 - check 7.1.2 after first checking for compliance

echo =========
echo CIS 7.1.2
echo =========

echo -n 'Ensure users must wait at least 7 days to change their password... '
OUTPUT=$(/bin/awk '$1 == "PASS_MIN_DAYS" && $2 >= 7 {print $0}' /etc/login.defs)
if [ "x$OUTPUT" != "x" ]; then
	echo OK
else
	echo Failed - attempting to fix automatically...
	sed -i -r 's/^ *PASS_MIN_DAYS\s*[0-9]+(.*)?$/PASS_MIN_DAYS   7\1/g' /etc/login.defs
fi
