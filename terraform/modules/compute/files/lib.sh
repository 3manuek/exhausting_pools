#!/usr/bin/env bash

function getDbIp {
    gcloud --format=json compute instances list --filter="tags:(database)" | jq -r '.[].networkInterfa
ces[].networkIP'
}