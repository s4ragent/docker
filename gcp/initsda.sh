#!/bin/bash
sfdisk -f /dev/sda << EOF
16,,83,*
EOF
reboot
