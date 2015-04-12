#!/bin/sh
cat >/etc/udev/rules.d/90-oracle.rules <<EOF
KERNEL=="loop30", OWNER:="grid", GROUP:="asmadmin", MODE:="666"
EOF 
