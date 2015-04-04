#/bin/bash
docker run --privileged=true -d --name racbase oraclelinux:7 /sbin/init
docker exec -i racbase /bin/bash -c 'cat >create_racbase.sh' <./create_racbase.sh
docker exec -i racbase /root/create_racbase.sh
