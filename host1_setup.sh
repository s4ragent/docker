#!/bin/bash
yum -y install git docker bridge-utils
yum -y update device-mapper
cp ./vxlan.service /etc/systemd/system/vxlan.service
cp ./vxlan.init /usr/local/bin/vxlan.init
chmod 0700 /usr/local/bin/vxlan.init
systemctl enable vxlan.service
systemctl start vxlan.service

mkdir /etc/vxlan
touch /etc/vxlan/all.ip
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

cp ./initloop.service /etc/systemd/system/initloop.service
cp ./initloop.sh /usr/local/bin/initloop.sh
chmod 0700 /usr/local/bin/initloop.sh
systemctl enable initloop.service
systemctl start initloop.service
