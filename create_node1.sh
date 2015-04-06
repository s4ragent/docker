#!/bin/bash
mkdir -p /docker/node1
qemu-img create -f raw -o size=20G /docker/node1/orahome.img
mkfs.ext4 /docker/node1/orahome.img
losetup /dev/loop31 /docker/node1/orahome.img

#gcloud preview docker pull gcr.io/your-project-id/example-image
docker run --privileged=true -d -h node1.public --name node1 --dns=127.0.0.1 /lib/modules:/lib/modules test:racbase /sbin/init
docker exec -i racbase /bin/bash -c 'cat >/root/create_oraclehome.sh' <./create_oraclehome.sh
docker exec -i racbase mount -t ext4 /dev/loop31 /u01
docker exec -i racbase sh /root/create_oraclehome.sh
