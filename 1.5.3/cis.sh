#!/bin/sh
#
# This file implements CIS Red Hat Enterprise Linux 7 Benchmark Level 2 - check 1.5.3 after first checking for compliance

echo =========
echo CIS 1.5.3
echo =========
echo Note that the pattern match specified by the CIS benchmark is incorrect and does not allow for valid whitespace before the grub2 password entries. On RHEL 7 this whitespace is normal if grub2-setpassword is used. This script allows for the whitespace.

echo -n 'Ensure /boot/grub2/grub.cfg contents pattern match ^set superusers=".*"\s*(?:#.*)?$... '
OUTPUT=$(sed -nr '/^\s*set superusers=".*"\s*(#.*)?$/p' /boot/grub2/grub.cfg)
if [ "x$OUTPUT" != "x" ]; then
	echo OK
else
	echo Failed - attempting to fix...
	grub2-setpassword
fi

echo -n 'Ensure /boot/grub2/grub.cfg contents pattern match ^password... '
OUTPUT=$(sed -nr '/^\s*password/p' /boot/grub2/grub.cfg)
if [ "x$OUTPUT" != "x" ]; then
	echo OK
else
	echo Failed - attempting to fix...
	grub2-setpassword
fi
