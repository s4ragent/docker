#!/bin/bash
docker exec -i node1 /bin/bash -c 'cat >/home/grid/grid_install.rsp' <./grid_install.rsp
docker exec -i node1 /bin/bash -c 'cat >/home/grid/asm.rsp' <./asm.rsp
docker exec -i node1 /bin/bash -c 'cat >/home/oracle/db_install.rsp' <./db_install.rsp
docker exec -i node1 /bin/bash -c 'cat >/home/grid/grid_install.sh' <./grid_install.sh
docker exec -i node1 /bin/bash -c 'cat >/home/grid/asm.sh' <./asm.sh
docker exec -i node1 /bin/bash -c 'cat >/home/oracle/db_install.sh' <./db_install.sh
docker exec -i node1 /bin/bash -c 'chown grid.asmadmin /home/grid/grid.*'
docker exec -i node1 /bin/bash -c 'chown grid.asmadmin /home/grid/asm.*'
docker exec -i node1 /bin/bash -c 'chown oracle.oinstall /home/oracle/db*'
