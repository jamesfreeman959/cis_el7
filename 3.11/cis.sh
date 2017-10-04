#!/bin/sh
#
# This file implements CIS Red Hat Enterprise Linux 7 Benchmark Level 2 - check 3.11 after first checking for compliance

echo ========
echo CIS 3.11
echo ========

echo -n 'Ensure httpd is uninstalled... '
OUTPUT=$(rpm -q httpd | grep "not installed" 2>/dev/null)
if [ "x$OUTPUT" != "x" ]; then
	echo OK
else
	echo Failed - please review whether this package is really required.
fi
