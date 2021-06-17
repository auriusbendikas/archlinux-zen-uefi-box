#!/bin/bash -xe

# Prepare for Ansible execution
mount -o remount,size=768M /run/archiso/cowspace
echo 'Server = https://ftp.acc.umu.se/mirror/archlinux/$repo/os/$arch' > /etc/pacman.d/mirrorlist
pacman --sync --refresh --noconfirm git ansible
git clone https://github.com/auriusbendikas/ansible-scripts

# Execute Ansible provision script
ansible-scripts/bin/run-playbook.sh ansible-playbook.yaml

# Clean package caches
yes | pacman --sysroot /mnt --sync --clean --clean

# Install OpenSSH and VirtualBox guest additions
pacstrap /mnt openssh haveged virtualbox-guest-utils-nox

# Setup network
cat << EOF > /mnt/etc/systemd/network/virtio.network
[Match]
Name=en*

[Network]
DHCP=ipv4
DNSSEC=no
DNSOverTLS=no
Domains=~.

EOF

# Run commands in arch-chroot
arch-chroot /mnt /bin/bash -xe < chroot-install.sh

# Enable services
systemctl --root=/mnt enable systemd-networkd systemd-resolved sshd haveged vboxservice

# Set next boot to boot from hard drive
efibootmgr --bootnext 0002

# Shrink VDI disk image
fstrim --verbose /mnt/boot/efi
fstrim --verbose /mnt

# Unmount chroot
umount -R /mnt
