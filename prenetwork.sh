#!/bin/bash
/bin/sleep 30s >>/tmp/pre.log 2>&1
/bin/umount /dev/shm >>/tmp/pre.log 2>&1
/bin/mount -t tmpfs -o rw,nosuid,nodev,noexec,relatime,size=1200m tmpfs /dev/shm >>/tmp/pre.log 2>&1
exit 0
