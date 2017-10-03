#!/bin/sh
#
# This file implements CIS Red Hat Enterprise Linux 7 Benchmark Level 2 - check 5.2.12 after first checking for compliance

echo ==========
echo CIS 5.2.12
echo ==========

echo -n Ensure all SUID/GUID command use is audited...
OUTPUT=$(IFS=$'\n';for i in `df --local -P|awk {'if (NR!=1) print $6'}|xargs -I '{}' find '{}' -xdev -type f \( -perm -2000 -o -perm -4000 \)`; do egrep -q "^ *\-a +(always,exit|exit,always) +\-F +path=$i +\-F +perm=x +\-F +auid>=500 +\-F +auid!=4294967295 +-k +privileged$" /etc/audit/audit.rules;if [ $? -ne 0 ]; then echo $i use is not properly audited;fi;done)
if [ "x$OUTPUT" == "x" ]; then
	echo OK
else
	echo Failed - attempting to fix
	IFS=$'\n'
	for i in `df --local -P|awk {'if (NR!=1) print $6'}|xargs -I '{}' find '{}' -xdev -type f \( -perm -2000 -o -perm -4000 \)`
		do 
		egrep -q "^ *\-a +(always,exit|exit,always) +\-F +path=$i +\-F +perm=x +\-F +auid>=500 +\-F +auid!=4294967295 +-k +privileged$" /etc/audit/audit.rules
		if [ $? -ne 0 ]; then 
			echo "-a always,exit -F path=$i -F perm=x -F auid>=500 -F auid!=4294967295 -k privileged" >> /etc/audit/rules.d/audit.rules
		fi
	done
	augenrules --load
fi
