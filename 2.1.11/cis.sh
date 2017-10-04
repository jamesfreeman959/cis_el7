#!/bin/sh
#
# This file implements CIS Red Hat Enterprise Linux 7 Benchmark Level 2 - check 2.1.11 after first checking for compliance

echo ==========
echo CIS 2.1.11
echo ==========

echo -n 'Ensure xinetd is uninstalled... '
OUTPUT=$(rpm -q xinetd | grep "not installed" 2>/dev/null)
if [ "x$OUTPUT" != "x" ]; then
	echo OK
else
	echo Failed - please review whether this package is really required.
fi
