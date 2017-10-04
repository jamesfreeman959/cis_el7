#!/bin/sh
#
# This file implements CIS Red Hat Enterprise Linux 7 Benchmark Level 2 - check 1.2.2 after first checking for compliance

echo =========
echo CIS 1.2.2
echo =========

echo -n 'Verify Red Hat GPG Key is Installed... '
OUTPUT=$(rpm -q gpg-pubkey | grep "not installed" 2>/dev/null)
if [ "x$OUTPUT" == "x" ]; then
	echo OK
else
	echo Failed - attempting to fix...
	yum -y install gpg-pubkey
fi
