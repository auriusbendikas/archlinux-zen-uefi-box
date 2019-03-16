#!/bin/bash -xe

# Linking systemd-resolved to /etc/resolv.conf for DNS server resolution from DHCP
ln --symbolic --force /var/run/systemd/resolve/resolv.conf /etc/resolv.conf

# Delete all logs
rm --recursive --force /var/log/*

# Create empty machine ID
cp /dev/null /etc/machine-id

# Shrink VDI disk image
fstrim --verbose /boot/efi
fstrim --verbose /
