#!/bin/bash
psql -h localhost -p 6432 -Upostgres -x console <<EOF
show stats; show pools; 
EOF