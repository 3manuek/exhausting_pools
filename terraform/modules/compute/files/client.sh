#!/bin/bash
source /usr/local/bin/lib.sh

useradd postgres 

apt update

apt install -y jq htop linux-tools-`uname -r` bc


cat > /etc/apt/sources.list.d/pgdg.list <<EOF
deb http://apt.postgresql.org/pub/repos/apt/ xenial-pgdg main
EOF

wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
apt-get update

# pg version reason is to stick to GL's version,only headers do not match
apt install -y postgresql-contrib-9.6 postgresql-client-9.6

mkdir -p /var/lib/postgresql
echo "*:*:*:user_bench:Odybench*" >> /var/lib/postgresql/.pgpass
chmod 0600 /var/lib/postgresql/.pgpass

DBIP=$(getDbIp)
