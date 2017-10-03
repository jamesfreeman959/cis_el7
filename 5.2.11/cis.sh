#!/bin/sh
#
# This file implements CIS Red Hat Enterprise Linux 7 Benchmark Level 2 - check 5.2.11 after first checking for compliance

echo ==========
echo CIS 5.2.11
echo ==========

echo -n Ensure creat is audited...
OUTPUT=$(sed -nr '/^ *-a +(always,exit|exit,always) +-F +arch=b32 +-S +creat +-S +open +-S +openat +-S +truncate +-S +ftruncate +-F +exit=-EACCES +-F +auid>=500 +-F +auid!=4294967295 +-k +access$/p' /etc/audit/audit.rules)
if [ "x$OUTPUT" != "x" ]; then
	echo OK
else
	echo Failed - attempting to fix
	echo "-a always,exit -F arch=b32 -S creat -S open -S openat -S truncate -S ftruncate -F exit=-EACCES -F auid>=500 -F auid!=4294967295 -k access" >> /etc/audit/rules.d/audit.rules
	augenrules --load
fi

echo -n Ensure creat is audited...
OUTPUT=$(sed -nr '/^ *-a +(always,exit|exit,always) +-F +arch=b32 +-S +creat +-S +open +-S +openat +-S +truncate +-S +ftruncate +-F +exit=-EPERM +-F +auid>=500 +-F +auid!=4294967295 +-k +access$/p' /etc/audit/audit.rules)
if [ "x$OUTPUT" != "x" ]; then
	echo OK
else
	echo Failed - attempting to fix
	echo "-a always,exit -F arch=b32 -S creat -S open -S openat -S truncate -S ftruncate -F exit=-EPERM -F auid>=500 -F auid!=4294967295 -k access" >> /etc/audit/rules.d/audit.rules
	augenrules --load
fi
