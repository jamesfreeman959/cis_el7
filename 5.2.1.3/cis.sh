#!/bin/sh
#
# This file implements CIS Red Hat Enterprise Linux 7 Benchmark Level 2 - check 5.2.1.3 after first checking for compliance

echo ===========
echo CIS 5.2.1.3
echo ===========

echo -n Ensure log files do not rotate when maximum size reached...
OUTPUT=$(sed -nr '/^\s*max_log_file_action\s*=\s*keep_logs\s*(#.*)?$/p' /etc/audit/auditd.conf)
if [ "x$OUTPUT" != "x" ]; then
	echo OK
else
	echo Failed - attempting to fix
	if [ "x$(sed -nr '/^\s*max_log_file_action\s*=\s*(.*)?$/p' /etc/audit/auditd.conf)" == "x" ]; then
		echo "max_log_file_action = keep_logs" >> /etc/audit/auditd.conf
	else
		sed -i -r 's/^\s*max_log_file_action\s*=\s*(.*)?$/max_log_file_action = keep_logs/g' /etc/audit/auditd.conf
	fi
fi
