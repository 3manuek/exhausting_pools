#!/bin/bash
source /usr/local/bin/lib.sh

set -x

BENCHDIR=/var/bench
mkdir -p ${BENCHDIR}/pgbouncer
mkdir -p ${BENCHDIR}/odyssey

BENCHID=$(openssl rand -hex 12)
TIME=${2:-"90"}
CONN=${3:-"1000"}
ITER=${4:-"20"}
RATE=${5:-"200"}
WORKERS=${WORKERS:-"1"}


case ${1} in
  pgbouncer)
    endpoint=$(getPgbouncerIp)
    ;;
  odyssey)
    endpoint=$(getPoolIp)
    ;;
  -i)
    endpoint=$(getDbIp)
    pgbench -i -h ${endpoint} -p 5432 -s 100  -U user_bench postgres
    exit
    ;;
  *)
    echo "Option not valid" ; exit 
    ;;
esac



cat > $BENCHDIR/${1}/${BENCHID}.meta <<EOF
TYPE=${1}
TIME=${TIME}
CONN=${CONN}
WORKERS=${WORKERS}
EOF

# psql -U user_bench -h ${endpoint} -p 6432 console

for i in $(seq 1 ${ITER})
do 
  pgbench  -h ${endpoint} -C --rate=${RATE} -p 6432 -T ${TIME} -C -c ${CONN} -n -U user_bench postgres | egrep 'tps|latency' | tee -a $BENCHDIR/${1}/${BENCHID}.log & 
done

