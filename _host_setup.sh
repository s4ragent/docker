
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
Address = 192.168.0.1${1}/24
Mode=bridge
EOF

cat >/etc/vxlan/vxlan1.conf <<EOF
vInterface = vxlan1
Id = 11
Ether = eth0
List = /etc/vxlan/all.ip
Address = 192.168.100.1${1}/24
Mode=bridge
EOF

cat >>/etc/sysctl.conf <<EOF
# oracle-rdbms-server-12cR1-preinstall setting for net.core.rmem_default is 262144
net.core.rmem_default = 262144
# oracle-rdbms-server-12cR1-preinstall setting for net.core.rmem_max is 4194304
net.core.rmem_max = 4194304
# oracle-rdbms-server-12cR1-preinstall setting for net.core.wmem_default is 262144
net.core.wmem_default = 262144
# oracle-rdbms-server-12cR1-preinstall setting for net.core.wmem_max is 1048576
net.core.wmem_max = 1048576
# oracle-rdbms-server-12cR1-preinstall setting for fs.aio-max-nr is 1048576
fs.aio-max-nr = 1048576
# oracle-rdbms-server-12cR1-preinstall setting for net.ipv4.ip_local_port_range is 9000 65500
net.ipv4.ip_local_port_range = 9000 65500
EOF
sysctl -p
