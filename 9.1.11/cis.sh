#!/bin/sh
#
# This file implements CIS Red Hat Enterprise Linux 7 Benchmark Level 2 - check 9.1.11 after first checking for compliance

echo ==========
echo CIS 9.1.11
echo ==========

echo -n 'Ensure all files have valid user... '
OUTPUT=$(df --local -P | awk {'if (NR!=1) print $6'} | xargs -I '{}' find '{}' -xdev -nouser -ls)
if [ "x$OUTPUT" == "x" ]; then
	echo OK
else
	echo Failed - please review the following files:
	echo $OUTPUT
fi
