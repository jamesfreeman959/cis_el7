#!/bin/sh
#
# This file implements CIS Red Hat Enterprise Linux 7 Benchmark Level 2 - check 5.2.8 after first checking for compliance

echo =========
echo CIS 5.2.8
echo =========

echo -n Ensure /var/log/faillog is audited...
OUTPUT=$(sed -nr '/^ *-w +\/var\/log\/faillog +-p +wa +-k +logins$/p' /etc/audit/audit.rules)
if [ "x$OUTPUT" != "x" ]; then
	echo OK
else
	echo Failed - attempting to fix
	echo "-w /var/log/faillog -p wa -k logins" >> /etc/audit/rules.d/audit.rules
	augenrules --load
fi

echo -n Ensure /var/log/lastlog is audited...
OUTPUT=$(sed -nr '/^ *-w +\/var\/log\/lastlog +-p +wa +-k +logins$/p' /etc/audit/audit.rules)
if [ "x$OUTPUT" != "x" ]; then
	echo OK
else
	echo Failed - attempting to fix
	echo "-w /var/log/lastlog -p wa -k logins" >> /etc/audit/rules.d/audit.rules
	augenrules --load
fi

echo -n Ensure /var/log/tallylog is audited...
OUTPUT=$(sed -nr '/^ *-w +\/var\/log\/tallylog +-p +wa +-k +logins$/p' /etc/audit/audit.rules)
if [ "x$OUTPUT" != "x" ]; then
	echo OK
else
	echo Failed - attempting to fix
	echo "-w /var/log/tallylog -p wa -k logins" >> /etc/audit/rules.d/audit.rules
	augenrules --load
fi
