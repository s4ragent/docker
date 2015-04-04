#!/bin/bash
#$1 container name
#$2 brigde name
#$3 container's inf name
#$4 ip addr
#ex xxx.sh node1 docker1 eth1 192.168.0.101/24
 
pid=`docker inspect -f '{{.State.Pid}}' $1`
mkdir -p /var/run/netns
ln -s /proc/${pid}/ns/net /var/run/netns/${pid}
veth=`perl -e 'print sprintf("%2.2x%2.2x%2.2x", rand()*255, rand()*255, rand()*255)'`
 
ip link add vethb${veth} type veth peer name vethc${veth}
 
brctl addif $2 vethb${veth}
ip link set vethb${veth} up
 
ip link set vethc${veth} netns ${pid}
ip netns exec ${pid} ip link set vethc${veth} down
ip netns exec ${pid} ip link set dev vethc${veth} name $3
ip netns exec ${pid} ip link set $3 up
 
vmac=`perl -e 'print sprintf("00:16:3e:%2.2x:%2.2x:%2.2x", rand()*255, rand()*255, rand()*255)'`
ip netns exec ${pid} ip link set $3 address $vmac
ip netns exec ${pid} ip addr add $4 dev $3 
