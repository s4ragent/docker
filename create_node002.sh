#!/bin/bash
#gcloud preview docker pull gcr.io/your-project-id/example-image
mkdir -p /docker/node002
qemu-img create -f raw -o size=20G /docker/node002/orahome.img
mkfs.ext4 -F /docker/node002/orahome.img
sh ./losetup.sh /dev/loop32 /docker/node002/orahome.img
docker run --privileged=true -d -h node002.public  --name node002 --dns=127.0.0.1 -v /lib/modules:/lib/modules test:racbase /sbin/init
bash ./docker_ip.sh node002 brvxlan0 eth1 192.168.0.102/24
bash ./docker_ip.sh node002 brvxlan1 eth2 192.168.100.102/24
sleep 35
docker exec -ti node002 /bin/bash -c 'mkdir /u01'
docker exec -ti node002 /bin/bash -c 'echo "/dev/loop32 /u01    ext4    defaults   0 0" >> /etc/fstab'
docker exec -ti node002 /bin/bash -c 'mount -a'
docker exec -i node002 /bin/bash -c 'cat >/root/create_oraclehome.sh' <./create_oraclehome.sh
docker exec -ti node002 sh /root/create_oraclehome.sh
#docker exec -i node2 /bin/bash -c 'cat >/root/nfsclient.sh' <./nfsclient.sh
#docker exec -i node2 sh -x /root/nfsclient.sh
