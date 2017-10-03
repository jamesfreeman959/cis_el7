#!/bin/sh
#
# This file implements CIS Red Hat Enterprise Linux 7 Benchmark Level 2 - check 5.2.5 after first checking for compliance

echo =========
echo CIS 5.2.5
echo =========

echo -n Ensure /etc/group is audited...
OUTPUT=$(sed -nr '/^ *-w +\/etc\/group +-p +wa +-k +identity$/p' /etc/audit/audit.rules)
if [ "x$OUTPUT" != "x" ]; then
	echo OK
else
	echo Failed - attempting to fix
	echo "-w /etc/group -p wa -k identity" >> /etc/audit/rules.d/audit.rules
	augenrules --load
fi

echo -n Ensure /etc/passwd is audited...
OUTPUT=$(sed -nr '/^ *-w +\/etc\/passwd +-p +wa +-k +identity$/p' /etc/audit/audit.rules)
if [ "x$OUTPUT" != "x" ]; then
	echo OK
else
	echo Failed - attempting to fix
	echo "-w /etc/passwd -p wa -k identity" >> /etc/audit/rules.d/audit.rules
	augenrules --load
fi

echo -n Ensure /etc/gshadow is audited...
OUTPUT=$(sed -nr '/^ *-w +\/etc\/gshadow +-p +wa +-k +identity$/p' /etc/audit/audit.rules)
if [ "x$OUTPUT" != "x" ]; then
	echo OK
else
	echo Failed - attempting to fix
	echo "-w /etc/gshadow -p wa -k identity" >> /etc/audit/rules.d/audit.rules
	augenrules --load
fi

echo -n Ensure /etc/shadow is audited...
OUTPUT=$(sed -nr '/^ *-w +\/etc\/shadow +-p +wa +-k +identity$/p' /etc/audit/audit.rules)
if [ "x$OUTPUT" != "x" ]; then
	echo OK
else
	echo Failed - attempting to fix
	echo "-w /etc/shadow -p wa -k identity" >> /etc/audit/rules.d/audit.rules
	augenrules --load
fi

echo -n Ensure /etc/security/opasswd is audited...
OUTPUT=$(sed -nr '/^ *-w +\/etc\/security\/opasswd +-p +wa +-k +identity$/p' /etc/audit/audit.rules)
if [ "x$OUTPUT" != "x" ]; then
	echo OK
else
	echo Failed - attempting to fix
	echo "-w /etc/security/opasswd -p wa -k identity" >> /etc/audit/rules.d/audit.rules
	augenrules --load
fi
