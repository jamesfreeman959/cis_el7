#!/bin/sh
#
# This file implements CIS Red Hat Enterprise Linux 7 Benchmark Level 2 - check 5.2.7 after first checking for compliance

echo =========
echo CIS 5.2.7
echo =========

echo -n Ensure /etc/selinux is audited...
OUTPUT=$(sed -nr '/^ *-w +\/etc\/selinux\/ +-p +wa +-k +MAC-policy$/p' /etc/audit/audit.rules)
if [ "x$OUTPUT" != "x" ]; then
	echo OK
else
	echo Failed - attempting to fix
	echo "-w /etc/selinux/ -p wa -k MAC-policy" >> /etc/audit/rules.d/audit.rules
	augenrules --load
fi
