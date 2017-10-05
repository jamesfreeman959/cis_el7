#!/bin/sh
#
# This file implements CIS Red Hat Enterprise Linux 7 Benchmark Level 2 - check 3.2 after first checking for compliance

echo =======
echo CIS 3.2
echo =======

echo -n 'Ensure the X Windows Server is uninstalled... '
OUTPUT=$(rpm -q xorg-x11-server-common | grep "not installed" 2>/dev/null)
if [ "x$OUTPUT" != "x" ]; then
	echo OK
else
	echo Failed - please review and remove the X Windows Server unless there is a genuine business need for it on this server.
fi

echo -n 'systemd Does Not Default To graphical.target... '
OUTPUT=$(ls -l /etc/systemd/system/default.target | grep graphical.target 2>/dev/null)
if [ "x$OUTPUT" == "x" ]; then
	echo OK
else
	echo Failed - please review and remove the X Windows Server unless there is a genuine business need for it on this server.
fi
