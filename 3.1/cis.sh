#!/bin/sh
#
# This file implements CIS Red Hat Enterprise Linux 7 Benchmark Level 2 - check 3.1 after first checking for compliance

echo =======
echo CIS 3.1
echo =======

echo -n 'Ensure daemon umask is set to 027... '
OUTPUT=$(sed -nr '/^umask 027/p' /etc/sysconfig/init)
if [ "x$OUTPUT" != "x" ]; then
	echo OK
else
	echo Failed - please review and fix in /etc/sysconfig/init if possible. Please note that this could break existing services so exercise care if implementing this change.
fi
