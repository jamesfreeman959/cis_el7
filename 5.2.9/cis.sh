#!/bin/sh
#
# This file implements CIS Red Hat Enterprise Linux 7 Benchmark Level 2 - check 5.2.9 after first checking for compliance

echo =========
echo CIS 5.2.9
echo =========

echo -n Ensure /var/run/utmp is audited...
OUTPUT=$(sed -nr '/^ *-w +\/var\/run\/utmp +-p +wa +-k +session$/p' /etc/audit/audit.rules)
if [ "x$OUTPUT" != "x" ]; then
	echo OK
else
	echo Failed - attempting to fix
	echo "-w /var/run/utmp -p wa -k session" >> /etc/audit/rules.d/audit.rules
	augenrules --load
fi

echo -n Ensure /var/log/wtmp is audited...
OUTPUT=$(sed -nr '/^ *-w +\/var\/log\/wtmp +-p +wa +-k +session$/p' /etc/audit/audit.rules)
if [ "x$OUTPUT" != "x" ]; then
	echo OK
else
	echo Failed - attempting to fix
	echo "-w /var/log/wtmp -p wa -k session" >> /etc/audit/rules.d/audit.rules
	augenrules --load
fi

echo -n Ensure /var/log/btmp is audited...
OUTPUT=$(sed -nr '/^ *-w +\/var\/log\/btmp +-p +wa +-k +session$/p' /etc/audit/audit.rules)
if [ "x$OUTPUT" != "x" ]; then
	echo OK
else
	echo Failed - attempting to fix
	echo "-w /var/log/btmp -p wa -k session" >> /etc/audit/rules.d/audit.rules
	augenrules --load
fi
