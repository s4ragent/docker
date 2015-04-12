#!/bin/bash
docker exec -i node1 /bin/bash -c 'cat >/home/grid/grid_install.rsp' <./grid_install.rsp
docker exec -i node1 /bin/bash -c 'cat >/home/grid/asm.rsp' <./asm.rsp
docker exec -i node1 /bin/bash -c 'cat >/home/oracle/db_install.rsp' <./db_install.rsp

