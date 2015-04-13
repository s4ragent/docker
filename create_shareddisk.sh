#!/bin/bash
mkdir -p /docker/share

qemu-img create -f raw -o size=20G /docker/share/share.img
