# Tiny Arch Linux vagrant box with LTS kernel

Automated packer builds of the minimal Arch Linux releases for virtualbox provider. Provisioned with bash and ansible scripts from [auriusbendikas/ansible-scripts](https://github.com/auriusbendikas/ansible-scripts)

## Features

* Size < 400 MiB
* LTS Linux kernel only
* No boot-loader. Boot directly via [EFISTUB](https://wiki.archlinux.org/index.php/EFISTUB)

## Installed packages

* bash
* bash-completion
* binutils
* bzip2
* coreutils
* cryptsetup
* device-mapper
* diffutils
* e2fsprogs
* file
* filesystem
* findutils
* gawk
* gcc-libs
* gettext
* glibc
* grep
* gzip
* haveged
* inetutils
* iproute2
* iputils
* less
* licenses
* linux-zen
* logrotate
* man-db
* man-pages
* nano
* openssh
* pacman
* pciutils
* procps-ng
* psmisc
* sed
* shadow
* sudo
* sysfsutils
* systemd-sysvcompat
* tar
* texinfo
* usbutils
* util-linux
* vi
* virtualbox-guest-dkms
* virtualbox-guest-utils-nox
* which

## Removed packages

Certain packages were forcefully removed breaking dependencies, but greatly reducing box size.

* dkms
* gcc
* linux-firmware
* linux-zen-headers
* make
