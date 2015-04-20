#/bin/bash
docker run --privileged=true -d --name racbase oraclelinux:7 /sbin/init
docker exec -i racbase /bin/bash -c 'cat >/root/create_racbase.sh' <./create_racbase.sh
docker exec -ti racbase sh /root/create_racbase.sh
docker exec -i racbase /bin/bash -c 'cat >/root/rules.sh' <./rules.sh
docker exec -ti racbase sh /root/rules.sh
docker exec -i racbase /bin/bash -c 'cat >/root/prenetwork.service' <./prenetwork.service
docker exec -i racbase /bin/bash -c 'cat >/root/prenetwork.sh' <./prenetwork.sh
docker exec -ti racbase /bin/bash -c 'cp /root/prenetwork.service /etc/systemd/system/prenetwork.service'
docker exec -ti racbase /bin/bash -c 'cp /root/prenetwork.sh /usr/local/bin/prenetwork.sh'
docker exec -ti racbase /bin/bash -c 'chmod 0700 /usr/local/bin/prenetwork.sh'
docker exec -ti racbase /bin/bash -c 'systemctl enable prenetwork.service'
docker stop racbase
docker commit racbase test:racbase
#docker tag test/racbase gcr.io/your-project-id/example-image
#gcloud preview docker push gcr.io/your-project-id/example-image

