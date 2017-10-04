#!/bin/sh
#
# This file implements CIS Red Hat Enterprise Linux 7 Benchmark Level 2 - check 1.6.1 after first checking for compliance

echo =========
echo CIS 1.6.1
echo =========

echo -n 'Ensure /etc/security/limits.conf contents pattern match ^\s*\*\shard\score\s0(\s+#.*)?$... '
OUTPUT=$(sed -nr '/^\*\s+hard\s+core\s+0/p' /etc/security/limits.conf)
if [ "x$OUTPUT" != "x" ]; then
	echo OK
else
	echo Failed - attempting to fix...
	echo "* hard core 0" >> /etc/security/limits.conf
fi

echo -n 'Ensure 'fs.suid_dumpable' kernel parameter equals 0 (int)... '
OUTPUT=$(sysctl fs.suid_dumpable | grep "fs.suid_dumpable = 0" 2>/dev/null)
if [ "x$OUTPUT" != "x" ]; then
	echo OK
else
	echo Failed - attempting to fix...
	if [ "x$(sed -nr '/^\s*fs\.suid_dumpable/p' /etc/sysctl.conf /etc/sysctl.d/*)" != "x" ]; then
		sed -i -r 's/^\s*fs\.suid_dumpable\s*=\s*(.*)?/fs.suid_dumpable = 0/g' /etc/sysctl.conf /etc/sysctl.d/*
		systemctl restart systemd-sysctl
	else
		echo "fs.suid_dumpable = 0" > /etc/sysctl.d/cis161.conf
		systemctl restart systemd-sysctl
	fi	
fi
