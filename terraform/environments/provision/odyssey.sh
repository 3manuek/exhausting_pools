#!/bin/bash

useradd odyssey

apt update

apt install -y cmake  build-essential libssl-dev

# Odyssey needs Pg 10 headers ->https://www.postgresql.org/download/linux/ubuntu/

mkdir /etc/odyssey
cp /tmp/odyssey.conf /etc/odyssey

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

cp ./sources/odyssey /usr/bin/
cp ../odyssey.conf /etc/odyssey.conf