#!/bin/bash
yum -y install iscsi-initiator-utils
#iscsiadm -m discovery -t sendtargets -p
iscsiadm -m node --login
