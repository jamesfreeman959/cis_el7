#!/bin/sh
#
# This file implements CIS Red Hat Enterprise Linux 7 Benchmark Level 2 - check 1.4.3 after first checking for compliance

echo =========
echo CIS 1.4.3
echo =========

echo -n 'Ensure SELINUXTYPE is targeted, strict, or mls... '
OUTPUT=$(sed -nr '/^\s*SELINUXTYPE=(targeted|strict|mls)/p' /etc/selinux/config) 
if [ "x$OUTPUT" != "x" ]; then
	echo OK
else
	echo Failed - please review this. Note that some vendors do not support SELinux so only turn it back on if you know this is a supported operation.
fi

echo 'Note that the pattern match from the CIS benchmark is incorrect for sestatus output and won''t work with RHEL 7. This check uses the corrected pattern match.'
echo -n 'Ensure policy from config file is targeted strict or mls... '
OUTPUT=$(sestatus | grep -e '^Loaded policy name:\s*\(targeted\|strict\|mls\)')
if [ "x$OUTPUT" != "x" ]; then
	echo OK
else
	echo Failed - please review this. Note that some vendors do not support SELinux so only turn it back on if you know this is a supported operation.
fi
