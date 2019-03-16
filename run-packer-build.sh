#!/bin/bash -e

OPTIONS=$@

if [ -z "${VAGRANT_CLOUD_TOKEN}" -a -z "${OPTIONS}" ]; then
    OPTIONS="-except=vagrant-cloud"
fi

packer build -force -var 'headless=false' ${OPTIONS} $(readlink -f $0 | xargs dirname)/archlinux.json
