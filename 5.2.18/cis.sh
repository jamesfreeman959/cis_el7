#!/bin/sh
#
# This file implements CIS Red Hat Enterprise Linux 7 Benchmark Level 2 - check 5.2.18 after first checking for compliance

echo ==========
echo CIS 5.2.18
echo ==========

echo -n 'Ensure  audit rules are immutable... '
OUTPUT=$(sed -nr '/^ *-e +2$/p' /etc/audit/audit.rules)
if [ "x$OUTPUT" != "x" ]; then
	echo OK
else
	echo Failed - attempting to fix
	echo "-e 2" >> /etc/audit/rules.d/audit.rules
	augenrules --load
fi
