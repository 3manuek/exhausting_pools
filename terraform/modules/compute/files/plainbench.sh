#!/bin/bash
source /usr/local/bin/lib.sh

set -x
DBIP=$(getDbIp)

pgbench -i -h ${DBIP} -p 6432 -s 100  -U user_bench postgres

for i in $(seq 1 30) ; do pgbench  -h ${DBIP} -p 6432 -T 45 -c 1000 -n -U user_bench postgres | egrep 'tps|latency' & done ;

