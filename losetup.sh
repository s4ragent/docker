#!/bin/bash
cnt=0
while true; do
        losetup $1 $2
        if [ $? -eq 0 ]; then
                break
        fi
        if [ $cnt -eq 10 ]; then
                echo "10 times losetup failed"
                exit 1
        fi
        cnt=`expr $cnt + 1 `
        sleep 3
done
