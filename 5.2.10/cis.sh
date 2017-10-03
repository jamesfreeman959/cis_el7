#!/bin/sh
#
# This file implements CIS Red Hat Enterprise Linux 7 Benchmark Level 2 - check 5.2.10 after first checking for compliance

echo =========
echo CIS 5.2.10
echo =========

echo -n Ensure chown is audited...
OUTPUT=$(sed -nr '/^ *-a +(always,exit|exit,always) +-F +arch=b32 +-S +chown +-S +fchown +-S +fchownat +-S +lchown +-F +auid>=500 +-F +auid!=4294967295 +-k +perm_mod$/p' /etc/audit/audit.rules)
if [ "x$OUTPUT" != "x" ]; then
	echo OK
else
	echo Failed - attempting to fix
	echo "-a always,exit -F arch=b32 -S chown -S fchown -S fchownat -S lchown -F auid>=500 -F auid!=4294967295 -k perm_mod" >> /etc/audit/rules.d/audit.rules
	augenrules --load
fi

echo -n Ensure chmod is audited...
OUTPUT=$(sed -nr '/^ *-a +(always,exit|exit,always) +-F +arch=b32 +-S +chmod +-S +fchmod +-S +fchmodat +-F +auid>=500 +-F +auid!=4294967295 +-k +perm_mod$/p' /etc/audit/audit.rules)
if [ "x$OUTPUT" != "x" ]; then
	echo OK
else
	echo Failed - attempting to fix
	echo "-a always,exit -F arch=b32 -S chmod -S fchmod -S fchmodat -F auid>=500 -F auid!=4294967295 -k perm_mod" >> /etc/audit/rules.d/audit.rules
	augenrules --load
fi

echo -n Ensure setxattr is audited...
OUTPUT=$(sed -nr '/^ *-a +(always,exit|exit,always) +-F +arch=b32 +-S +setxattr +-S +lsetxattr +-S +fsetxattr +-S +removexattr +-S +lremovexattr +-S +fremovexattr +-F +auid>=500 +-F +auid!=4294967295 +-k +perm_mod$/p' /etc/audit/audit.rules)
if [ "x$OUTPUT" != "x" ]; then
	echo OK
else
	echo Failed - attempting to fix
	echo "-a always,exit -F arch=b32 -S setxattr -S lsetxattr -S fsetxattr -S removexattr -S lremovexattr -S fremovexattr -F auid>=500 -F auid!=4294967295 -k perm_mod" >> /etc/audit/rules.d/audit.rules
	augenrules --load
fi
