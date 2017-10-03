#!/bin/sh
#
# This file implements CIS Red Hat Enterprise Linux 7 Benchmark Level 2 - check 5.2.6 after first checking for compliance

echo =========
echo CIS 5.2.6
echo =========

echo -n Ensure sethostname is audited...
OUTPUT=$(sed -nr '/^ *-a +(always,exit|exit,always) +-F +arch=b32 +-S +sethostname +-S +setdomainname +-k +system-locale$/p' /etc/audit/audit.rules)
if [ "x$OUTPUT" != "x" ]; then
	echo OK
else
	echo Failed - attempting to fix
	echo "-a always,exit -F arch=b32 -S sethostname -S setdomainname -k system-locale" >> /etc/audit/rules.d/audit.rules
	augenrules --load
fi

echo -n Ensure /etc/issue is audited...
OUTPUT=$(sed -nr '/^ *-w +\/etc\/issue +-p +wa +-k +system-locale$/p' /etc/audit/audit.rules)
if [ "x$OUTPUT" != "x" ]; then
	echo OK
else
	echo Failed - attempting to fix
	echo "-w /etc/issue -p wa -k system-locale" >> /etc/audit/rules.d/audit.rules
	augenrules --load
fi

echo -n Ensure /etc/issue.net is audited...
OUTPUT=$(sed -nr '/^ *-w +\/etc\/issue.net +-p +wa +-k +system-locale$/p' /etc/audit/audit.rules)
if [ "x$OUTPUT" != "x" ]; then
	echo OK
else
	echo Failed - attempting to fix
	echo "-w /etc/issue.net -p wa -k system-locale" >> /etc/audit/rules.d/audit.rules
	augenrules --load
fi

echo -n Ensure /etc/hosts is audited...
OUTPUT=$(sed -nr '/^ *-w +\/etc\/hosts +-p +wa +-k +system-locale$/p' /etc/audit/audit.rules)
if [ "x$OUTPUT" != "x" ]; then
	echo OK
else
	echo Failed - attempting to fix
	echo "-w /etc/hosts -p wa -k system-locale" >> /etc/audit/rules.d/audit.rules
	augenrules --load
fi

echo -n Ensure /etc/sysconfig/network is audited...
OUTPUT=$(sed -nr '/^ *-w +\/etc\/sysconfig\/network +-p +wa +-k +system-locale$/p' /etc/audit/audit.rules)
if [ "x$OUTPUT" != "x" ]; then
	echo OK
else
	echo Failed - attempting to fix
	echo "-w /etc/sysconfig/network -p wa -k system-locale" >> /etc/audit/rules.d/audit.rules
	augenrules --load
fi
