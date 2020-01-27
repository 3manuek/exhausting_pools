# poc-odyssey

Odyssey Pool Stress scenario.

## Objective

It is intended to test Odyssey on stressed environments. 



## Architecture

In order to save infrastructure resources, benchs can run to pgbouncer and
odyssey but not at the same time. Both pools point to the same database endpoint and
client can point indistintively to each of the pools.


```mermaid
graph TB
    odysseyp["Odyssey"] -. Pool Size=32 .-> Postgres
    pgbouncer["PgBouncer"] -. Pool Size=32 .-> Postgres
    pgbench["PgBench"] -. unlimited clients .-> odysseyp
    pgbench["PgBench"] -. max_client_conn=100k .-> pgbouncer

    subgraph CLI["Client Compute"]
        pgbench["PgBench"]
        pgbench_N["PgBench...N"]
    end
    subgraph PGB["Pgbouncer Compute"]
        pgbouncer["PgBouncer"]
    end
    subgraph ODY["Odyssey Compute"]
        odysseyp["Odyssey Parent"] -.- odysseysys
        odysseyp["Odyssey Parent"] -. workers=N .- odysseyworkerN
        odysseysys["Odyssey System"]
        odysseyworkerN["Odyssey Workers"]
    end
    subgraph PG["Postgres Compute"]
        Postgres
        Postgres --- disk("pd-ssd")
    end
```

## Setup

### Install requirements

```
https://github.com/adammck/terraform-inventory
gcloud
terraform
```



> Note: If you don't have setup a Postgres backend for Terraform, do it first and change
> the connection string accordingly.

> OnGres members Note: there is an existent backend database created for this project.
> Contact: emanuel at ongres.com

Create an `.env` file with the following configuration:


```bash
export PROJECT=<project>
export BACKEND_CONNSTR="conn_str=postgres://user:pass@<URI>/poc_odyssey_tfstate"
```

Before executing anything, authenticate through `gcloud` -- create an Editor privileged Service Account:

```
gcloud auth login
gcloud auth activate-service-account --key-file=$HOME/.gcloud/postgresql-support-dev-terraform-admin.json
gcloud auth application-default login
```

## init

```bash
make ENV=testing init
```

Then, as usual:

```bash
make ENV=testing plan|apply
```

## Bench tests

From any client (points to database endpoint):

```
/usr/local/bin/plainbench.sh -i
```


```
/usr/local/bin/plainbench.sh [odyssey|pgbouncer] [secs] [conn] [iter]
```

eg:

```
/usr/local/bin/plainbench.sh odyssey 20 500 20
```
