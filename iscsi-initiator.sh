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

systemctl start iscsid
systemctl enable iscsid

iscsiadm -m discovery -t sendtargets -p 192.168.0.10
iscsiadm -m node --login

sfdisk /dev/sdb << EOF
,,83
EOF

dd if=/dev/zero of=/dev/sdb1 bs=1M count=100
