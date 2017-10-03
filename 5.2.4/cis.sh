#!/bin/sh
#
# This file implements CIS Red Hat Enterprise Linux 7 Benchmark Level 2 - check 5.2.4 after first checking for compliance

echo =========
echo CIS 5.2.4
echo =========

echo -n Ensure adjtimex is audited...
OUTPUT=$(sed -nr '/^ *-a +(always,exit|exit,always) +-F +arch=b32 +-S +adjtimex +-S +settimeofday +-S +stime +-k +time-change$/p' /etc/audit/audit.rules)
if [ "x$OUTPUT" != "x" ]; then
	echo OK
else
	echo Failed - attempting to fix
	echo "-a always,exit -F arch=b32 -S adjtimex -S settimeofday -S stime -k time-change" >> /etc/audit/rules.d/audit.rules
	augenrules --load
fi

echo -n Ensure clock_settime is audited...
OUTPUT=$(sed -nr '/^ *-a +(always,exit|exit,always) +-F +arch=b32 +-S +clock_settime +-k +time-change$/p' /etc/audit/audit.rules)
if [ "x$OUTPUT" != "x" ]; then
	echo OK
else
	echo Failed - attempting to fix
	echo "-a always,exit -F arch=b32 -S clock_settime -k time-change" >> /etc/audit/rules.d/audit.rules
	augenrules --load
fi

echo -n Ensure time-change is audited...
OUTPUT=$(sed -nr '/^ *-w +\/etc\/localtime +-p +wa +-k +time-change$/p' /etc/audit/audit.rules)
if [ "x$OUTPUT" != "x" ]; then
	echo OK
else
	echo Failed - attempting to fix
	echo "-w /etc/localtime -p wa -k time-change" >> /etc/audit/rules.d/audit.rules
	augenrules --load
fi
