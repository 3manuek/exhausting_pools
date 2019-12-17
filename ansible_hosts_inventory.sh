#!/bin/bash
project_dir=$(pwd)

set -x

cd ${project_dir}/terraform/environments/testing
export odyssey_external_ip=`terraform output -json | jq -r .odyssey_external_ip.value[0][0]`
export postgres_external_ip=`terraform output -json | jq -r .postgres_external_ip.value[0][0]`

if ([ -z ${odyssey_external_ip} ] && [ -z ${postgres_external_ip} ])
then
  echo "*** nothing to do ****"
  exit 1
fi

if [ -s ${project_dir}/ansible/inventory/hosts.yaml ]
then
  rm ${project_dir}/ansible/inventory/hosts.yaml
fi

cat >> ${project_dir}/ansible/inventory/hosts.yaml << EOF

all:
  children:
    postgres:
      hosts:
        ${postgres_external_ip}:
    odyssey:
      hosts:
        ${odyssey_external_ip}:
EOF