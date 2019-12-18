#!/bin/bash
project_dir=$(pwd)
hostsyaml="${project_dir}/ansible/inventory/hosts.yaml"


set -x

cd ${project_dir}/terraform/environments/testing
export odyssey_external_ip=`terraform output -json | jq -r .odyssey_external_ip.value[0][0]`
export postgres_external_ip=`terraform output -json | jq -r .postgres_external_ip.value[0][0]`

if ([ -z ${odyssey_external_ip} ] && [ -z ${postgres_external_ip} ])
then
  echo "*** nothing to do ****"
  exit 1
fi

if [ -s ${hostsyaml} ]
then
  rm ${hostsyaml}
fi

cat >> ${hostsyaml} << EOF

all:
  children:
    postgres:
      hosts:
        ${postgres_external_ip}:
    odyssey:
      hosts:
        ${odyssey_external_ip}:
EOF