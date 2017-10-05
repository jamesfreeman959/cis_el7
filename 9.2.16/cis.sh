#!/bin/sh
#
# This file implements CIS Red Hat Enterprise Linux 7 Benchmark Level 2 - check 9.2.16 after first checking for compliance

echo ==========
echo CIS 9.2.16
echo ==========

echo -n 'Check That Reserved UIDs Are Assigned to System Accounts... '
OUTPUT=$(defUsers="root bin daemon adm lp sync shutdown halt mail news uucp operator games gopher ftp nobody nscd vcsa rpc mailnull smmsp pcap ntp dbus avahi sshd rpcuser nfsnobody haldaemon avahi-autoipd distcache apache oprofile webalizer dovecot squid named xfs gdm sabayon usbmuxd rtkit abrt saslauth pulse postfix tcpdump"; /bin/cat /etc/passwd | /bin/awk -F: '($3 < 1000) {print $1" "$3 }' | while read user uid; do found=0; for tUser in ${defUsers}; do if [ ${user} = ${tUser} ]; then found=1; fi; done; if [ $found -eq 0 ]; then echo "User $user has a reserved UID ($uid)."; fi; done)
if [ "x$OUTPUT" == "x" ]; then
	echo OK
else
	echo Failed - please review and fix the following accounts if possible.
	defUsers="root bin daemon adm lp sync shutdown halt mail news uucp operator games gopher ftp nobody nscd vcsa rpc mailnull smmsp pcap ntp dbus avahi sshd rpcuser nfsnobody haldaemon avahi-autoipd distcache apache oprofile webalizer dovecot squid named xfs gdm sabayon usbmuxd rtkit abrt saslauth pulse postfix tcpdump"; /bin/cat /etc/passwd | /bin/awk -F: '($3 < 1000) {print $1" "$3 }' | while read user uid; do found=0; for tUser in ${defUsers}; do if [ ${user} = ${tUser} ]; then found=1; fi; done; if [ $found -eq 0 ]; then echo "User $user has a reserved UID ($uid)."; fi; done
fi
