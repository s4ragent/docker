#!/bin/bash
for i in {2..63}; 
do
  if [ -e /dev/loop$i ]; then 
    continue
  fi
  mknod /dev/loop$i b 7 $i
  chown --reference=/dev/loop0 /dev/loop$i
  chmod --reference=/dev/loop0 /dev/loop$i
done
