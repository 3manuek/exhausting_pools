#!/bin/bash
abspath=$(pwd)

set -x

cd ${abspath}/terraform/environments/testing
export odyssey_external_ip=`terraform output -json | jq -r .odyssey_external_ip.value[0][0]`
export postgres_external_ip=`terraform output -json | jq -r .postgres_external_ip.value[0][0]`

if ([ -z ${odyssey_external_ip} ] && [ -z ${postgres_external_ip} ])
then
  echo "*** nothing to do ****"
  exit 1
fi

if [ -s ${abspath}/ansible/inventory/hosts.yaml ]
then
  rm ${abspath}/ansible/inventory/hosts.yaml
fi

cat >> ${abspath}/ansible/inventory/hosts.yaml << EOF

all:
  children:
    postgres:
      hosts:
        ${postgres_external_ip}:
    odyssey:
      hosts:
        ${odyssey_external_ip}:
EOF