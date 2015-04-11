#!/bin/bash

#mkdir -p /docker/nfs
#qemu-img create -f raw -o size=20G /docker/nfs/nfs.img
#mkfs.ext4 -F /docker/nfs/nfs.img
#sh -x ./losetup.sh /dev/loop30 /docker/nfs/nfs.img
#docker run --privileged=true -d -h nfs.public --name nfs --dns=127.0.0.1 -v /lib/modules:/lib/modules test:racbase /sbin/init
#sh ./docker_ip.sh nfs brvxlan0 eth1 192.168.0.10/24
#sleep 35
#docker exec -i nfs /bin/bash -c 'mkdir /nfs'
#docker exec -i nfs /bin/bash -c 'echo "/dev/loop30 /nfs    ext4    defaults   0 0" >> /etc/fstab'
#docker exec -i nfs /bin/bash -c 'mount -a'
#docker exec -i nfs /bin/bash -c 'cat >/root/nfsserver.sh' <./nfsserver.sh
#docker exec -i nfs sh /root/nfsserver.sh

yum -y install nfs-utils
ip addr add 192.168.0.10/24 dev brvxlan0
sh ./nfsserver.sh
