#!/bin/sh
mkdir -p /nfs/oracleasm
echo "/nfs/oracleasm *(rw,sync,no_root_squash)" >> /etc/exports
chmod -R 775 /nfs
#echo 'MOUNTD_NFS_V3="yes"'>> /etc/sysconfig/nfs
#http://www.server-world.info/query?os=CentOS_7&p=nfs

systemctl restart rpcbind
systemctl start nfs-server
systemctl start nfs-lock
systemctl start nfs-idmap

systemctl enable rpcbind
systemctl enable nfs-server
