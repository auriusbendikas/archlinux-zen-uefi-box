#!/bin/bash -e

OPTIONS=$@

if [ -z "${VAGRANT_CLOUD_TOKEN}" -a -z "${OPTIONS}" ]; then
    OPTIONS="-except=vagrant-cloud"
fi

OPTIONS="${OPTIONS} -var iso_name=$(curl https://mirror.rackspace.com/archlinux/iso/latest/sha256sums.txt | head -n 1 | awk '{print $2}')"

packer build -force -var 'headless=false' ${OPTIONS} $(readlink -f $0 | xargs dirname)/archlinux.json
