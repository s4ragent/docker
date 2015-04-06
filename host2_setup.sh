#!/bin/bash
yum -y install git docker bridge-utils qemu-img
yum -y update device-mapper

dd if=/dev/zero of=/var/tmp/swap.img bs=1M count=8192
mkswap /var/tmp/swap.img
sh -c 'echo "/var/tmp/swap.img swap swap defaults 0 0" >> /etc/fstab'
swapon -a 

cp ./vxlan.service /etc/systemd/system/vxlan.service
cp ./vxlan.init /usr/local/bin/vxlan.init
chmod 0700 /usr/local/bin/vxlan.init
systemctl enable vxlan.service
systemctl start vxlan.service

cp ./initloop.service /etc/systemd/system/initloop.service
cp ./initloop.sh /usr/local/bin/initloop.sh
chmod 0700 /usr/local/bin/initloop.sh
systemctl enable initloop.service
systemctl start initloop.service

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
