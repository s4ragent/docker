#!/bin/bash
ORA_ORACLE_BASE=/u01/app/oracle
ORA_ORACLE_HOME=/u01/app/oracle/product/12.1.0/dbhome_1
GRID_ORACLE_BASE=/u01/app/grid
GRID_ORACLE_HOME=/u01/app/12.1.0/grid
ORAINVENTORY=/u01/app/oraInventory
MOUNT_PATH=/u01
MEDIA_PATH=/media
mkdir -p ${GRID_ORACLE_BASE}
mkdir -p ${GRID_ORACLE_HOME}
mkdir -p ${MEDIA_PATH}
chown -R grid:oinstall ${MOUNT_PATH}
mkdir -p ${ORA_ORACLE_BASE}
chown oracle:oinstall ${ORA_ORACLE_BASE}
chmod -R 775 ${MOUNT_PATH}
