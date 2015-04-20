#!/bin/bash
docker stop node1
docker stop node2
docker stop racbase
docker rm node1
docker rm node2
docker rm racbase
docker rmi test:racbase
losetup -d /dev/loop30
losetup -d /dev/loop31
losetup -d /dev/loop32
bash -x ./create_shared disk.sh
bash -x ./create_basecontainer.sh
bash -x ./create_node1.sh
bash -x ./create_node2.sh
docker exec -ti node1 expect /root/setup_ssh.expect oracle oracle123
docker exec -ti node1 expect /root/setup_ssh.expect grid grid123
docker exec -ti node1 cat /home/oracle/.ssh/id_rsa > oraclekey.pem
docker exec -ti node1 cat /home/grid/.ssh/id_rsa > gridkey.pem
chmod 0600 *.pem
ssh -i gridkey.pem -o StrictHostKeyChecking=no -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null grid@192.168.0.101 sh grid_install.sh
docker exec -ti node1 /u01/app/oraInventory/orainstRoot.sh
docker exec -ti node2 /u01/app/oraInventory/orainstRoot.sh

docker exec -ti node1 /u01/app/12.1.0/grid/root.sh
docker exec -ti node2 /u01/app/12.1.0/grid/root.sh

ssh -i gridkey.pem -o StrictHostKeyChecking=no -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null grid@192.168.0.101 sh asm.sh
docker exec -ti node1 /u01/app/12.1.0/grid/bin/crsctl status resource -t

ssh -i oraclekey.pem -o StrictHostKeyChecking=no -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null oracle@192.168.0.101 sh db_install.sh

docker exec -ti node1 /u01/app/oracle/product/12.1.0/dbhome_1/root.sh
docker exec -ti node2 /u01/app/oracle/product/12.1.0/dbhome_1/root.sh

ssh -i oraclekey.pem -o StrictHostKeyChecking=no -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null oracle@192.168.0.101 sh dbca.sh
docker exec -ti node1 /u01/app/12.1.0/grid/bin/crsctl status resource -t
