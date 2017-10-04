#!/bin/sh
#
# This file implements CIS Red Hat Enterprise Linux 7 Benchmark Level 2 - check 6.2.11 after first checking for compliance

echo ==========
echo CIS 6.2.11
echo ==========

echo -n 'Ensure SSH Ciphers is set to aes128-ctr,aes192-ctr,aes256-ctr... '
OUTPUT=$(grep '^\s*Ciphers\s' /etc/ssh/sshd_config | head -1 | sed -nr '/\s*\S+\s+(.+?)\s*(#.*)?$/p')
if [ "x$OUTPUT" != "x" ]; then
	echo OK
else
	echo Failed - please review SSH Ciphers and fix if appropriate
fi
