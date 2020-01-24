#!/bin/bash
source /usr/local/bin/lib.sh
# NOTE: we want to use artifacts, but just for now, we compile straight.
# variables

useradd pgbouncer
DBIP=$(getPoolIp)

apt update

apt install -y pgbouncer

cat > /etc/pgbouncer/pgbouncer.ini <<EOF
[databases]
postgres host=${DBIP} auth_user=user_bench password=Odybench* pool_size=32

listen_port = 6433
listen_addr = *

query_wait_timeout = 0

auth_type = trust
auth_file = /etc/pgbouncer/userlist.txt

EOF

cat > /etc/pgbouncer/userlist.ini <<EOF
"user_bench" "Odybench*"
EOF

systemctl enable pgbouncer.service 
systemctl start pgbouncer.service 
