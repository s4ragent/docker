#!/bin/bash
#gcloud preview docker pull gcr.io/your-project-id/example-image
mkdir -p /docker/node1
mkdir -p /docker/media
qemu-img create -f raw -o size=20G /docker/node1/orahome.img
mkfs.ext4 -F /docker/node1/orahome.img
sh ./losetup.sh /dev/loop31 /docker/node1/orahome.img
dd if=/dev/zero of=/dev/loop30 bs=1M count=100
docker run --privileged=true -d -h node1.public  --name node1 --dns=127.0.0.1 -v /lib/modules:/lib/modules -v /docker/media:/media test:racbase /sbin/init
bash ./docker_ip.sh node1 brvxlan0 eth1 192.168.0.101/24
bash ./docker_ip.sh node1 brvxlan1 eth2 192.168.100.101/24
sleep 35
docker exec -ti node1 /bin/bash -c 'mkdir /u01'
docker exec -ti node1 /bin/bash -c 'echo "/dev/loop31 /u01    ext4    defaults   0 0" >> /etc/fstab'
docker exec -ti node1 /bin/bash -c 'mount -a'
docker exec -i node1 /bin/bash -c 'cat >/root/create_oraclehome.sh' <./create_oraclehome.sh
docker exec -ti node1 sh /root/create_oraclehome.sh
#docker exec -i node1 /bin/bash -c 'cat >/root/nfsclient.sh' <./nfsclient.sh
#docker exec -i node1 sh /root/nfsclient.sh

docker exec -i node1 /bin/bash -c 'cat >/home/grid/grid_install.rsp' <./grid_install.rsp
docker exec -i node1 /bin/bash -c 'cat >/home/grid/grid_install.sh' <./grid_install.sh
docker exec -ti node1 /bin/bash -c 'chown grid.asmadmin /home/grid/grid*'
docker exec -i node1 /bin/bash -c 'cat >/home/grid/asm.rsp' <./asm.rsp
docker exec -i node1 /bin/bash -c 'cat >/home/grid/asm.sh' <./asm.sh
docker exec -ti node1 /bin/bash -c 'chown grid.asmadmin /home/grid/asm.*'
docker exec -i node1 /bin/bash -c 'cat >/home/oracle/db_install.rsp' <./db_install.rsp
docker exec -i node1 /bin/bash -c 'cat >/home/oracle/db_install.sh' <./db_install.sh
docker exec -ti node1 /bin/bash -c 'chown oracle.oinstall /home/oracle/db*'

docker exec -i node1 /bin/bash -c 'cat >/root/setup_ssh.expect' <./setup_ssh.expect
docker exec -i node1 /bin/bash -c 'cat >/home/oracle/dbca.sh' <./dbca.sh
docker exec -ti node1 /bin/bash -c 'chown oracle.oinstall /home/oracle/dbca.sh'
