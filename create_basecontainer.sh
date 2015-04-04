#/bin/bash
docker run --privileged=true -d --name racbase oraclelinux:7 /sbin/init
docker exec -i racbase /bin/bash -c 'cat >/root/create_racbase.sh' <./create_racbase.sh
docker exec -i racbase sh /root/create_racbase.sh
