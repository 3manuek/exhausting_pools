#!/bin/bash

#https://www.postgresql.org/download/linux/ubuntu/

cat > /etc/apt/sources.list.d/pgdg.list <<EOF
deb http://apt.postgresql.org/pub/repos/apt/ xenial-pgdg main
EOF

wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
apt-get update -y

apt install -y postgresql-client-9.6 postgresql-9.6 parted

# Initialize disk

# mkdir /opt/data 2> /dev/null

# parted /dev/sdb mklabel data
# parted -a optimal /dev/sdb mkpart primary 0% 100%
# mkfs.xfs /dev/sdb 
# mount -o defaults,nofail,noatime,noexec,nodiratime,noquota /dev/sdb1 /data

# init data on it


# start service

