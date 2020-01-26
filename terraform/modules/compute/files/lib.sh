#!/usr/bin/env bash

function getDbIp {
    gcloud --format=json compute instances list --filter="tags:(database)" | jq -r '.[].networkInterfaces[].networkIP'
}

function getPoolIp {
    gcloud --format=json compute instances list --filter="tags:(odyssey)" | jq -r '.[].networkInterfaces[].networkIP'
}

function getPgbouncerIp {
    gcloud --format=json compute instances list --filter="tags:(pgbouncer)" | jq -r '.[].networkInterfaces[].networkIP'
}