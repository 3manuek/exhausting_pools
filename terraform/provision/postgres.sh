#!/bin/bash

#https://www.postgresql.org/download/linux/ubuntu/

cat > /etc/apt/sources.list.d/pgdg.list <<EOF
deb http://apt.postgresql.org/pub/repos/apt/ xenial-pgdg main
EOF

wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
apt-get update -y

apt install -y postgresql-client-9.6 postgresql-9.6 parted htop jq bc 

# Initialize disk

# mkdir /var/lib/postgresql/data 2> /dev/null

# parted /dev/sdb mklabel data
# parted -a optimal /dev/sdb mkpart primary 0% 100%
# mkfs.xfs /dev/sdb
# mount -o defaults,nofail,noatime,noexec,nodiratime,noquota /dev/sdb1 /data


# drop default cluster cluster
runuser -u postgres -p -- pg_dropcluster 9.6 main --stop

# create new cluster

runuser -u postgres -p -- pg_createcluster 9.6 bench -e "UTF-8" -p 5432

# add pg_hba conf
echo "host    all             all             0.0.0.0/0            md5" >> /etc/postgresql/9.6/bench/pg_hba.conf

# create custom conf file

cat > /etc/postgresql/9.6/bench/custom_configuration.conf <<__EOF__

listen_addresses = '*'
max_connections = 300
shared_buffers = 16GB
checkpoint_completion_target = 0.9
random_page_cost = 1.1
effective_cache_size = 45GB
default_statistics_target = 200
log_destination = 'stderr'
logging_collector = on
log_directory = 'pg_log'
log_checkpoints = on
log_connections = on
log_disconnections = on
log_duration = on


__EOF__

# add custom conf to pg
echo "include = '/etc/postgresql/9.6/bench/custom_configuration.conf'" >> /etc/postgresql/9.6/bench/postgresql.conf

# start the cluster

runuser -u postgres -p -- pg_ctlcluster 9.6 bench start

# add benchmarck user
runuser -u postgres -p -- psql -c "CREATE ROLE user_bench WITH superuser login ENCRYPTED PASSWORD 'Odybench*' "
