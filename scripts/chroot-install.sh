#!/bin/bash -xe

/usr/bin/generate-efi-image

# Create vagrant user and group
groupadd --gid 1000 vagrant
useradd --uid 1000 --gid vagrant --groups users,wheel,input,vboxsf --create-home --comment "Vagrant User" vagrant
echo -e "vagrant\nvagrant" | passwd vagrant

# Setting no password sudo for wheel user group
cat << EOF > /etc/sudoers.d/wheel
%wheel ALL=(ALL) NOPASSWD: ALL
EOF
chmod 440 /etc/sudoers.d/wheel

# Lock root account
passwd --lock root

# Install vagrant public ssh key
install --directory --owner=vagrant --group=vagrant --mode=0700 /home/vagrant/.ssh
curl --output /home/vagrant/.ssh/authorized_keys --location https://raw.githubusercontent.com/hashicorp/vagrant/master/keys/vagrant.pub
chown vagrant:vagrant /home/vagrant/.ssh/authorized_keys
chmod 0600 /home/vagrant/.ssh/authorized_keys

# Deleting unnecessary packages to reduce download size
sudo pacman --remove --nosave --recursive --nodeps --nodeps --noconfirm make gcc dkms linux-firmware
sudo pacman --remove --nosave --recursive --nodeps --nodeps --noconfirm linux-zen-headers

# Clean package caches
yes | pacman --sync --clean --clean
