#!/bin/bash

# NOTE: we want to use artifacts, but just for now, we compile straight.

useradd odyssey

apt update

apt install -y cmake  build-essential libssl-dev

# Odyssey needs Pg 10 headers ->https://www.postgresql.org/download/linux/ubuntu/

mkdir /etc/odyssey


cat > /etc/odyssey/odyssey.conf <<EOF
daemonize no
unix_socket_dir "/tmp"
unix_socket_mode "0644"
log_format "%p %t %l [%i %s] (%c) %m\n"
log_to_stdout yes
log_syslog no
log_syslog_ident "odyssey"
log_syslog_facility "daemon"
log_debug no
log_config yes
log_session yes
log_query no
log_stats yes
stats_interval 60
workers 1
resolvers 1
readahead 8192
cache_coroutine 0
coroutine_stack_size 8
nodelay yes
keepalive 7200
listen {
        host "*"
        port 6432
        backlog 128
}
storage "postgres_server" {
        type "remote"
        host "localhost"
        port 5432
}
database default {
        user default {
                authentication "none"
                storage "postgres_server"
                pool "session"
                pool_size 0
                pool_timeout 0
                pool_ttl 60
                pool_discard no
                pool_cancel yes
                pool_rollback yes
                client_fwd_error yes
                log_debug no
        }
}

storage "local" {
        type "local"
}

database "console" {
        user default {
                authentication "none"
                pool "session"
                storage "local"
        }
}
EOF

cat > /etc/odyssey/entrypoint.conf <<EOF

EOF

cat > /etc/systemd/system/odyssey.service <<EOF
After=network.target

[Service]
User=odyssey
Group=odyssey
Type=simple
ExecStart=/usr/bin/odyssey /etc/odyssey/odyssey.conf
LimitNOFILE=100000
LimitNPROC=100000

[Install]
WantedBy=multi-user.target
EOF


cat > /etc/apt/sources.list.d/pgdg.list <<EOF
deb http://apt.postgresql.org/pub/repos/apt/ xenial-pgdg main
EOF

wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
apt-get update

# pg version reason is to stick to GL's version,only headers do not match
apt install -y postgresql-server-dev-10 postgresql-contrib-9.6 postgresql-client-9.6

#
git clone git://github.com/yandex/odyssey.git
cd odyssey
mkdir build
cd build
cmake -DCMAKE_BUILD_TYPE=Release ..
make


cp sources/odyssey /usr/bin/
cp ../odyssey.conf /etc/odyssey/odyssey.conf

systemctl enable odyssey.service
