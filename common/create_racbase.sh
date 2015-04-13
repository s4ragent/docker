#!/bin/bash
GRID_PASSWORD=grid123
ORACLE_PASSWORD=oracle123
ORA_ORACLE_BASE=/u01/app/oracle
ORA_ORACLE_HOME=/u01/app/oracle/product/12.1.0/dbhome_1
GRID_ORACLE_BASE=/u01/app/grid
GRID_ORACLE_HOME=/u01/app/12.1.0/grid
ORAINVENTORY=/u01/app/oraInventory
MOUNT_PATH=/u01
MEDIA_PATH=/media

yum --enablerepo=ol7_addons install oracle-rdbms-server-12cR1-preinstall tar net-tools sleep expect -y
yum reinstall -y glibc-common

###delete user ###
userdel -r oracle
userdel -r grid
groupdel dba
groupdel oinstall
groupdel oper
groupdel asmadmin
groupdel asmdba
groupdel asmoper

##create user/group####
groupadd -g 601 oinstall
groupadd -g 602 dba
groupadd -g 603 oper
groupadd -g 1001 asmadmin
groupadd -g 1002 asmdba
groupadd -g 1003 asmoper
useradd -u 501 -m -g oinstall -G dba,oper,asmdba -d /home/oracle -s /bin/bash -c"Oracle Software Owner" oracle
useradd -u 1001 -m -g oinstall -G asmadmin,asmdba,asmoper -d /home/grid -s /bin/bash -c "Grid Infrastructure Owner" grid

 

##edit password ##
echo "grid:$GRID_PASSWORD" | chpasswd
echo "oracle:$ORACLE_PASSWORD" | chpasswd

### edit bash &bashrc ###
cat >> /home/oracle/.bashrc <<'EOF'
#this is for oracle install#
if [ -t 0 ]; then
   stty intr ^C
fi
EOF

cat >> /home/grid/.bashrc <<'EOF'
#this is for oracle install#
if [ -t 0 ]; then
   stty intr ^C
fi
EOF

cat >> /home/oracle/.bash_profile <<EOF
### for oracle install ####
export ORACLE_BASE=${ORA_ORACLE_BASE}
export ORACLE_HOME=${ORA_ORACLE_HOME}
EOF

cat >> /home/oracle/.bash_profile <<'EOF'
export TMPDIR=/tmp
export TEMP=/tmp
export PATH=$ORACLE_HOME/bin:$ORACLE_HOME/jdk/bin:${PATH}
export LD_LIBRARY_PATH=$ORACLE_HOME/lib
EOF

cat >> /home/grid/.bash_profile <<EOF
### for grid install####
export ORACLE_BASE=${GRID_ORACLE_BASE}
export ORACLE_HOME=${GRID_ORACLE_HOME}
EOF

cat >> /home/grid/.bash_profile <<'EOF'
export TMPDIR=/tmp
export TEMP=/tmp
export PATH=$ORACLE_HOME/bin:$ORACLE_HOME/jdk/bin:${PATH}
export LD_LIBRARY_PATH=$ORACLE_HOME/lib
EOF
 
cat >> /home/oracle/.bash_profile <<'EOF'
export NLS_LANG=JAPANESE_JAPAN.UTF8
export LANG=ja_JP.UTF-8
export LC_ALL=ja_JP.UTF-8
EOF

cat >> /home/grid/.bash_profile <<'EOF'
export NLS_LANG=JAPANESE_JAPAN.UTF8
export LANG=ja_JP.UTF-8
export LC_ALL=ja_JP.UTF-8
EOF

##create ssh key####
#mkdir -p /work/
#ssh-keygen -t rsa -P "" -f /work/id_rsa
#
#for user in oracle grid
#do
#        mkdir /home/$user/.ssh
#        cat /work/id_rsa.pub >> /home/$user/.ssh/authorized_keys
#        cp /work/id_rsa /home/$user/.ssh/
#        for i in `seq 1 4`; do
#             ssh-keyscan -t rsa localhost | sed "s/localhost/node${i},192.168.0.10${i}/" >> /work/known_hosts
#        done
#        cp /work/known_hosts /home/$user/.ssh
#        chown -R ${user}.oinstall /home/$user/.ssh
#        chmod 700 /home/$user/.ssh
#        chmod 600 /home/$user/.ssh/*
#done
#rm -rf /work

#enable non root user ping
chmod u+s /usr/bin/ping

#cp /etc/hosts /tmp/hosts
#sed -i.bak 's:/etc/hosts:/tmp/hosts:g' /lib64/libnss_files.so.2
cat << EOT >> /tmp/hosts
192.168.0.101 node1.public node1
192.168.0.102 node2.public node2
192.168.0.103 node3.public node3
192.168.0.104 node4.public node4
192.168.0.201 node1-vip.public node1-vip
192.168.0.202 node2-vip.public node2-vip
192.168.0.203 node3-vip.public node3-vip
192.168.0.204 node4-vip.public node4-vip
192.168.0.31 scan.public scan
192.168.0.32 scan.public scan
192.168.0.33 scan.public scan
EOT

#http://qiita.com/inokappa/items/89ab9b7f39bc1ad2f197
yum -y install dnsmasq bind-utils

cat << EOT >> /etc/dnsmasq.conf
listen-address=127.0.0.1
resolv-file=/etc/resolv.dnsmasq.conf
conf-dir=/etc/dnsmasq.d
user=root
addn-hosts=/tmp/hosts
EOT

cat << EOT >> /etc/resolv.dnsmasq.conf
nameserver 8.8.8.8
nameserver 8.8.4.4
EOT

systemctl enable dnsmasq