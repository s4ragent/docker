#!/bin/bash
#http://www.server-world.info/query?os=CentOS_7&p=iscsi
yum -y install targetcli
ip addr add 192.168.0.10/24 dev brvxlan0
mkdir /iscsi_disks
targetcli backstores/fileio create disk01 /iscsi_disks/disk01.img 20G
targetcli backstores/fileio create disk02 /iscsi_disks/disk02.img 20G
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
