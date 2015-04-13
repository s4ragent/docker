#!/bin/bash
yum -y install iscsi-initiator-utils
#iscsiadm -m discovery -t sendtargets -p
#iscsiadm -m node --login
echo "InitiatorName=iqn.2015-06.org.jpoug:node${1}" > /etc/iscsi/initiatorname.iscsi
cat >> /etc/iscsi/iscsid.conf <<EOF
node.session.auth.authmethod = CHAP
node.session.auth.username = oracle
node.session.auth.password = oracle123
EOF

systemctl stop iscsi
systemctl stop iscsid
systemctl start iscsid
systemctl enable iscsid

iscsiadm -m discovery -t sendtargets -p 192.168.0.10
iscsiadm -m node --login
sleep 10

sfdisk /dev/sdb << EOF
,,83
EOF

./losetup.sh /dev/loop30 /dev/sdb1