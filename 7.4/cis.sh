#!/bin/sh
#
# This file implements CIS Red Hat Enterprise Linux 7 Benchmark Level 2 - check 7.4 after first checking for compliance

echo =======
echo CIS 7.4
echo =======

echo -n 'Ensure /etc/bashrc umask allows access by owner only... '
OUTPUT=$(sed -nr '/^\s*umask\s+077/p' /etc/bashrc)
if [ "x$OUTPUT" != "x" ]; then
	echo OK
else
	echo Failed - please review and fix if required. Note that this could break applications running under unprivileged user accounts so please review carefully before implementing in /etc/bashrc.
fi

echo -n 'Ensure /etc/profile.d/* umask allows access by owner only... '
OUTPUT=$(egrep ^[[:space:]]*umask[[:space:]]+077 /etc/profile.d/*)
if [ "x$OUTPUT" != "x" ]; then
	echo OK
else
	echo 'Failed - please review and fix if required. Note that this could break applications running under unprivileged user accounts so please review carefully before implementing in /etc/profile.d/*'
fi
