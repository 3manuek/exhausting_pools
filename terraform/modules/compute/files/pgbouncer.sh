#!/bin/bash
source /usr/local/bin/lib.sh
# NOTE: we want to use artifacts, but just for now, we compile straight.
# variables

useradd pgbouncer
DBIP=$(getDbIp)

apt update

apt install -y pgbouncer

cat > /etc/pgbouncer/pgbouncer.ini <<EOF
[databases]
postgres =  host=${DBIP} auth_user=user_bench password='Odybench*' pool_size=32
[users]
[pgbouncer]
logfile = /var/log/postgresql/pgbouncer.log
pidfile = /var/run/postgresql/pgbouncer.pid
listen_addr = *
listen_port = 6432
unix_socket_dir = /var/run/postgresql
auth_type = trust
auth_file = /etc/pgbouncer/userlist.txt
admin_users = user_bench 
max_client_conn = 100000
default_pool_size = 32
query_wait_timeout = 0

EOF

cat > /etc/pgbouncer/userlist.ini <<EOF
"user_bench" "Odybench*"
EOF

cat > /etc/systemd/system/pgbouncer.service <<EOF
[Unit]
Description=PgBouncer
After=network.target

[Service]
User=postgres
Group=postgres
ExecStart=/usr/sbin/pgbouncer /etc/pgbouncer/pgbouncer.ini
ExecReload=/usr/sbin/pgbouncer -R /etc/pgbouncer/pgbouncer.ini
StandardOutput=journal
StandardError=journal
LimitNOFILE=200000

[Install]
WantedBy=multi-user.target
EOF

systemctl enable pgbouncer.service 
systemctl start pgbouncer.service 
