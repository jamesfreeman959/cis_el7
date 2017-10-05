#!/bin/sh
#
# This file implements CIS Red Hat Enterprise Linux 7 Benchmark Level 2 - check 6.2.3 after first checking for compliance

echo =========
echo CIS 6.2.3
echo =========

echo -n 'Ensure /etc/ssh/sshd_config is owned and accesible by root only... '
OUTPUT=$(stat -L -c "%a %u %g" /etc/ssh/sshd_config | sed -nr '/.00 0 0/p')
if [ "x$OUTPUT" != "x" ]; then
	echo OK
else
	echo Failed - attempting to fix...
	chown 0:0 /etc/ssh/sshd_config
	chmod 0600 /etc/ssh/sshd_config
fi
