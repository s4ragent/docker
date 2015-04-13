#!/bin/bash
sfdisk /dev/sda << EOF
16,,83
EOF
reboot
