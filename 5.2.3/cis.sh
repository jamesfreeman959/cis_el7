#!/bin/sh
#
# This file implements CIS Red Hat Enterprise Linux 7 Benchmark Level 2 - check 5.2.3 after first checking for compliance

echo =========
echo CIS 5.2.3
echo =========

echo -n Enable Auditing for Processes That Start Prior to auditd...
OUTPUT=$(sed -nr '/^\s*linux(16)?\s+([^#]*audit=1).*$/p' /boot/grub2/grub.cfg)
if [ "x$OUTPUT" != "x" ]; then
	echo OK
else
	echo Failed - attempting to fix
	grubby --args=audit=1 --update-kernel=ALL
fi
