#!/bin/bash
mkdir -p /docker/share

qemu-img create -f raw -o size=20G /docker/share/share.img
sh ./losetup.sh /dev/loop30 /docker/share/share.img
echo "/sbin/losetup /dev/loop30 /docker/share/share.img" >> /usr/local/bin/initloop.sh
