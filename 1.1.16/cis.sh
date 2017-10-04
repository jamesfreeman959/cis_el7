#!/bin/sh
#
# This file implements CIS Red Hat Enterprise Linux 7 Benchmark Level 2 - check 1.1.16 after first checking for compliance

echo ==========
echo CIS 1.1.16
echo ==========

echo -n 'Ensure noexec set on /dev/shm partition... '
OUTPUT=$(egrep "^[^#]" /etc/fstab | awk '($2 == "/dev/shm") { print $4 }' | grep noexec)
if [ "x$OUTPUT" != "x" ]; then
	echo OK
else
	echo Failed - attempting to fix...
	if [ "x$(egrep '^[^#]' /etc/fstab | awk '($2 == "/dev/shm") { print $4 }')" == "x" ]; then
		echo adding...
		MOUNT=$(mount | grep '/dev/shm')
		MOUNTSTRING="$(echo $MOUNT | awk '{print $1}')	$(echo $MOUNT | awk '{print $3}')	$(echo $MOUNT | awk '{print $5}') $(echo $MOUNT | awk '{print $6}' | sed 's/(//g' | sed 's/)//g'),noexec 0 0"
		echo $MOUNTSTRING >> /etc/fstab
		echo "You will need to reboot for this change to come into effect..."
	else
		echo amending...
		sed -i -r 's/(.*)?[ \t]+\/dev\/shm[ \t]+(.*)?[ \t]+(.*)?[ \t]+([0-9])[ |\t]+([0-9])/\1\t\/dev\/shm\t\2\t\3,noexec\t\4 \5/g' /etc/fstab
	fi
fi
