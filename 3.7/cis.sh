#!/bin/sh
#
# This file implements CIS Red Hat Enterprise Linux 7 Benchmark Level 2 - check 3.7 after first checking for compliance

echo =======
echo CIS 3.7
echo =======

echo -n 'Ensure openldap-servers is uninstalled... '
OUTPUT=$(rpm -q openldap-servers | grep "not installed" 2>/dev/null)
if [ "x$OUTPUT" != "x" ]; then
	echo OK
else
	echo Failed - please review whether this package is really required.
fi

echo -n 'Ensure openldap-clients is uninstalled... '
OUTPUT=$(rpm -q openldap-clients | grep "not installed" 2>/dev/null)
if [ "x$OUTPUT" != "x" ]; then
        echo OK
else
        echo Failed - please review whether this package is really required.
fi
