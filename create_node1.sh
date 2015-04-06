#!/bin/bash
mkdir -p /docker/node1
qemu-img create -f raw -o size=20G /docker/node1/orahome.img
mkfs.ext4 /docker/node1/orahome.img
losetup /dev/loop31 /docker/node1/orahome.img
