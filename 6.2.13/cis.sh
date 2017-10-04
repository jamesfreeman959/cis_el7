#!/bin/sh
#
# This file implements CIS Red Hat Enterprise Linux 7 Benchmark Level 2 - check 6.2.13 after first checking for compliance

echo ==========
echo CIS 6.2.13
echo ==========

echo -n 'Ensure SSH remote user restriction is configured... '
OUTPUT=$(sed -nr '/^\s*(AllowUsers|AllowGroups|DenyUsers|DenyGroups)\s+.*/p' /etc/ssh/sshd_config)
if [ "x$OUTPUT" != "x" ]; then
	echo OK
else
	echo Failed - please review SSH user restrictions and fix if appropriate.
fi
