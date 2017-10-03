#!/bin/sh
#
# This file implements CIS Red Hat Enterprise Linux 7 Benchmark Level 2 - check 5.2.16 after first checking for compliance

echo ==========
echo CIS 5.2.16
echo ==========

echo -n 'Ensure /etc/audit/audit.rules contents pattern match ^-w /var/log/sudo.log -p wa -k actions$... '
OUTPUT=$(sed -nr '/^ *-w +\/var\/log\/sudo.log +-p +wa +-k +actions$/p' /etc/audit/audit.rules)
if [ "x$OUTPUT" != "x" ]; then
	echo OK
else
	echo Failed - attempting to fix
	echo "-w /var/log/sudo.log -p wa -k actions" >> /etc/audit/rules.d/audit.rules
	augenrules --load
fi
