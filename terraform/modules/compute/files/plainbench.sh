#!/bin/bash
source /usr/local/bin/lib.sh

set -x
DBIP=$(getPoolIp)

[ $1 == "-i" ] && pgbench -i -h ${DBIP} -p 6432 -s 100  -U user_bench postgres

for i in $(seq 1 20)
do 
  pgbench  -h ${DBIP} -C -p 6432 -T 90 -C -c 1000 -n -U user_bench postgres | egrep 'tps|latency' & 
done

