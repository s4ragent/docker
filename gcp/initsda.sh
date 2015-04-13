#!/bin/bash
sfdisk /dev/sda << EOF
,,83
EOF
reboot
