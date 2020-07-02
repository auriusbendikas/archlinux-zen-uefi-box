#!/bin/bash -xe

# Delete all logs
rm --recursive --force /var/log/*

# Create empty machine ID
cp /dev/null /etc/machine-id

# Shrink VDI disk image
fstrim --verbose /boot/efi
fstrim --verbose /
