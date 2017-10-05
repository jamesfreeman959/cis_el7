#!/bin/sh
#
# This file implements CIS Red Hat Enterprise Linux 7 Benchmark Level 2 - check 3.6 after first checking for compliance

echo =======
echo CIS 3.6
echo =======

echo -n 'Checking for presence of NTP on this server... '
OUTPUT=$(rpm -q ntp | grep "not installed" 2>/dev/null)
if [ "x$OUTPUT" == "x" ]; then
	echo OK
else
	echo 'NTP not installed on this server - exiting. Note that this server might fail CIS benchmark checks as /etc/ntp.conf is checked, and won''t be present on this server.'
	exit 0
fi

echo -n 'Ensure "restrict default kod nomodify notrap nopeer noquery" set in /etc/ntp.conf... '
OUTPUT=$(sed -nr '/^\s*restrict default kod nomodify notrap nopeer noquery/p' /etc/ntp.conf)
if [ "x$OUTPUT" != "x" ]; then
	echo OK
else
	echo Failed - please review /etc/ntp.conf - it should contain a line like this:
	echo
	echo restrict default kod nomodify notrap nopeer noquery
	echo
fi

echo -n 'Ensure "restrict -6 default kod nomodify notrap nopeer noquery" set in /etc/ntp.conf... '
OUTPUT=$(sed -nr '/^\s*restrict -6 default kod nomodify notrap nopeer noquery/p' /etc/ntp.conf)
if [ "x$OUTPUT" != "x" ]; then
	echo OK
else
	echo Failed - please review /etc/ntp.conf - it should contain a line like this:
	echo
	echo restrict -6 default kod nomodify notrap nopeer noquery
	echo
fi

echo -n 'Ensure at least one NTP server specified in /etc/ntp.conf... '
OUTPUT=$(sed -nr '/^\s*server/p' /etc/ntp.conf)
if [ "x$OUTPUT" != "x" ]; then
	echo OK
else
	echo Failed - please review /etc/ntp.conf - it should contain a line like this:
	echo
	echo server ntp.example.com
	echo
fi

echo -n 'Ensure NTP runs as an unpriviledged user... '
OUTPUT=$(sed -nr '/^OPTIONS=".*?-u ntp:ntp.*?"/p' /etc/sysconfig/ntpd)
if [ "x$OUTPUT" != "x" ]; then
	echo OK
else
	echo Failed - please note however that this failure is marked against the CIS Benchmark for RHEL 7 which is incorrect - RHEL 7 set''s the user for ntpd in /usr/lib/systemd/system/ntpd.service
fi
