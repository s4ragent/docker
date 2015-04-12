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
echo "plese this command "
echo "iscsiadm -m discovery -t sendtargets -p <targetip>"
echo "iscsiadm -m node --login"
echo "losetup /dev/loop30 /dev/sdb"
