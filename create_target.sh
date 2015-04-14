#!/bin/bash
#http://www.server-world.info/query?os=CentOS_7&p=iscsi
yum -y install targetcli
mkdir /iscsi_disks
targetcli backstores/fileio create disk01 /iscsi_disks/disk01.img 20G
targetcli backstores/fileio create disk02 /iscsi_disks/disk02.img 20G
targetcli /backstores/fileio/disk01 set attribute emulate_write_cache=0
targetcli /backstores/fileio/disk02 set attribute emulate_write_cache=0
targetcli /iscsi create iqn.2015-06.org.jpoug:crs.target00
targetcli /iscsi/iqn.2015-06.org.jpoug:crs.target00/tpg1/luns create /backstores/fileio/disk01
targetcli /iscsi/iqn.2015-06.org.jpoug:crs.target00/tpg1/luns create /backstores/fileio/disk02
targetcli /iscsi/iqn.2015-06.org.jpoug:crs.target00/tpg1/acls create iqn.2015-06.org.jpoug:node1
targetcli /iscsi/iqn.2015-06.org.jpoug:crs.target00/tpg1/acls create iqn.2015-06.org.jpoug:node2
targetcli /iscsi/iqn.2015-06.org.jpoug:crs.target00/tpg1/acls/iqn.2015-06.org.jpoug:node1 set auth userid=oracle
targetcli /iscsi/iqn.2015-06.org.jpoug:crs.target00/tpg1/acls/iqn.2015-06.org.jpoug:node2 set auth userid=oracle
targetcli /iscsi/iqn.2015-06.org.jpoug:crs.target00/tpg1/acls/iqn.2015-06.org.jpoug:node1 set auth password=oracle123 
targetcli /iscsi/iqn.2015-06.org.jpoug:crs.target00/tpg1/acls/iqn.2015-06.org.jpoug:node2 set auth password=oracle123
targetcli saveconfig
systemctl enable target
echo "iSCSI target IP is"
ip a show eth0 | grep "inet " | awk -F '[/ ]' '{print $6}'
