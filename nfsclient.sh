#!/bin/sh
echo "192.168.0.10:/nfs/oracleasm /oracleasm nfs rw,bg,hard,nointr,tcp,noac,vers=4,timeo=600,actimeo=0,rsize=32768,wsize=32768 0 0" >> /etc/fstab
mkdir /oracleasm
mount /oracleasm
if [ ! -e /oracleasm/crs.img ]; then
        dd if=/dev/zero of=/oracleasm/crs.img bs=1M count=12288
fi
chown -R grid:asmadmin /oracleasm
chmod -R 775 /oracleasm
