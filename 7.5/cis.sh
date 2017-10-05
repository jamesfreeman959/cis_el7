#!/bin/sh
#
# This file implements CIS Red Hat Enterprise Linux 7 Benchmark Level 2 - check 7.5 after first checking for compliance

echo =======
echo CIS 7.5
echo =======

echo -n 'Ensure accounts will be locked after 35 days inactivity... '
OUTPUT=$(useradd -D | awk -F=  '( $1 == "INACTIVE" && $2 >= 35 ) {print $2}')
if [ "x$OUTPUT" != "x" ]; then
	echo OK
else
	echo Failed - please review and fix if required. Note that this could break applications running under unprivileged user accounts so please review carefully before implementing.
fi
