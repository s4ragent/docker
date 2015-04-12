#!/bin/bash
#http://www.server-world.info/query?os=CentOS_7&p=iscsi
mkdir /iscsi_disks
targetcli backstores/fileio create disk01 /iscsi_disks/disk01.img 20G
targetcli /iscsi create iqn.2015-06.org.jpoug:crs.target00
targetcli /iscsi/iqn.2015-06.org.jpoug:crs.target00/tpg1/luns create /backstores/fileio/disk01
targetcli saveconfig
