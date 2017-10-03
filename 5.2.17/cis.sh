#!/bin/sh
#
# This file implements CIS Red Hat Enterprise Linux 7 Benchmark Level 2 - check 5.2.17 after first checking for compliance

echo ==========
echo CIS 5.2.17
echo ==========

echo -n 'Ensure /sbin/insmod is audited... '
OUTPUT=$(sed -nr '/^ *-w +\/sbin\/insmod +-p +x +-k +modules$/p' /etc/audit/audit.rules)
if [ "x$OUTPUT" != "x" ]; then
	echo OK
else
	echo Failed - attempting to fix
	echo "-w /sbin/insmod -p x -k modules" >> /etc/audit/rules.d/audit.rules
	augenrules --load
fi

echo -n 'Ensure /sbin/rmmod is audited... '
OUTPUT=$(sed -nr '/^ *-w +\/sbin\/rmmod +-p +x +-k +modules$/p' /etc/audit/audit.rules)
if [ "x$OUTPUT" != "x" ]; then
	echo OK
else
	echo Failed - attempting to fix
	echo "-w /sbin/rmmod -p x -k modules" >> /etc/audit/rules.d/audit.rules
	augenrules --load
fi

echo -n 'Ensure /sbin/modprobe is audited... '
OUTPUT=$(sed -nr '/^ *-w +\/sbin\/modprobe +-p +x +-k +modules$/p' /etc/audit/audit.rules)
if [ "x$OUTPUT" != "x" ]; then
	echo OK
else
	echo Failed - attempting to fix
	echo "-w /sbin/modprobe -p x -k modules" >> /etc/audit/rules.d/audit.rules
	augenrules --load
fi

echo -n 'Ensure init_module is audited... '
OUTPUT=$(sed -nr '/^ *-a +(always,exit|exit,always) +-F +arch=b32 +-S +init_module +-S +delete_module +-k +modules$/p' /etc/audit/audit.rules)
if [ "x$OUTPUT" != "x" ]; then
	echo OK
else
	echo Failed - attempting to fix
	echo "-a always,exit -F arch=b32 -S init_module -S delete_module -k modules" >> /etc/audit/rules.d/audit.rules
	augenrules --load
fi
