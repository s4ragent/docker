#!/bin/bash
cp ./vxlan.service /etc/systemd/system/vxlan.service
cp ./vxlan.init /usr/local/bin/vxlan.init
chmod 0700 /usr/local/bin/vxlan.init
systemctl enable vxlan.service
systemctl start vxlan.service

cat >/etc/vxlan/vxlan0.conf <<EOF
vInterface = vxlan0
Id = 10
Ether = eth0
List = /etc/vxlan/all.ip
Address = 192.168.0.11/24
Mode=bridge
EOF

cat >/etc/vxlan/vxlan1.conf <<EOF
vInterface = vxlan1
Id = 11
Ether = eth0
List = /etc/vxlan/all.ip
Address = 192.168.100.11/24
Mode=bridge
EOF
