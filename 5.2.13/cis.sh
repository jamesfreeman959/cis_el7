#!/bin/sh
#
# This file implements CIS Red Hat Enterprise Linux 7 Benchmark Level 2 - check 5.2.13 after first checking for compliance

echo ==========
echo CIS 5.2.13
echo ==========

echo -n 'Ensure /etc/audit/audit.rules contents pattern match ^-a always,exit -F arch=b32 -S mount -F auid>=1000 -F auid!=4294967295 -k mounts$...'
OUTPUT=$(sed -nr '/^ *-a +(always,exit|exit,always) +-F +arch=b32 +-S +mount +-F +auid>=500 +-F +auid!=4294967295 +-k +mounts$/p' /etc/audit/audit.rules)
if [ "x$OUTPUT" != "x" ]; then
	echo OK
else
	echo Failed - attempting to fix
	echo "-a always,exit -F arch=b32 -S mount -F auid>=500 -F auid!=4294967295 -k mounts" >> /etc/audit/rules.d/audit.rules
	augenrules --load
fi

echo -n 'Ensure /etc/audit/audit.rules contents pattern match ^-a always,exit -F arch=b64 -S mount -F auid>=1000 -F auid!=4294967295 -k mounts$...'
OUTPUT=$(sed -nr '/^ *-a +(always,exit|exit,always) +-F +arch=b64 +-S +mount +-F +auid>=500 +-F +auid!=4294967295 +-k +mounts$/p' /etc/audit/audit.rules)
if [ "x$OUTPUT" != "x" ]; then
	echo OK
else
	echo Failed - attempting to fix
	echo "-a always,exit -F arch=b64 -S mount -F auid>=500 -F auid!=4294967295 -k mounts" >> /etc/audit/rules.d/audit.rules
	augenrules --load
fi
