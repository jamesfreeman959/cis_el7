#!/bin/sh
#
# This file implements CIS Red Hat Enterprise Linux 7 Benchmark Level 2 - check 6.3.4 after first checking for compliance

echo =========
echo CIS 6.3.4
echo =========

echo -n 'User password history is remembered... '
OUTPUT=$(sed -nr '/^[^#]*remember/p' /etc/pam.d/system-auth)
if [ "x$OUTPUT" != "x" ]; then
	echo OK
else
	echo Failed - not fixing automatically. Please review /etc/pam.d/system-auth and consider adding something like:
	echo password sufficient pam_unix.so sha512 shadow nullok try_first_pass use_authtok remember=5
	echo
	echo However be careful especially of IPA authentication.
fi
