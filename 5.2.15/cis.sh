#!/bin/sh
#
# This file implements CIS Red Hat Enterprise Linux 7 Benchmark Level 2 - check 5.2.15 after first checking for compliance

echo ==========
echo CIS 5.2.15
echo ==========

echo -n 'Ensure /etc/audit/audit.rules contents pattern match ^-w /etc/sudoers -p wa -k scope$...'
OUTPUT=$(sed -nr '/^ *-w +\/etc\/sudoers +-p +wa +-k +scope$/p' /etc/audit/audit.rules)
if [ "x$OUTPUT" != "x" ]; then
	echo OK
else
	echo Failed - attempting to fix
	echo "-w /etc/sudoers -p wa -k scope" >> /etc/audit/rules.d/audit.rules
	augenrules --load
fi
