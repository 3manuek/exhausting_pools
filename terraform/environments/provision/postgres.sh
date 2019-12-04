#!/bin/bash

#https://www.postgresql.org/download/linux/ubuntu/

cat > /etc/apt/sources.list.d/pgdg.list <<EOF
deb http://apt.postgresql.org/pub/repos/apt/ xenial-pgdg main
EOF

wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
apt-get update

apt install postgresql-client-9.6
apt install postgresql-9.6

# Initialize disk


# init data on it


# start service

