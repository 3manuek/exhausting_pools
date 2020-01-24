# poc-odyssey

Odyssey Pool Stress scenario.

## Objective

It is intended to test Odyssey on stressed environments. 



## Architecture

```mermaid
graph TB
    odysseyp["Odyssey"] -.  Pool Size: s/Threads*2  .-> Postgres
    pgbench["PgBench"] --> odysseyp
    pgbenchN["PgBench"] --> odysseyp

    subgraph CLI["Client Compute"]
        pgbench["PgBench"]
        pgbench_N["PgBench...N"]
    end
    subgraph CLN["Client Compute N"]
        pgbenchN["PgBench"]
        pgbenchN_N["PgBench...N"]
    end
    subgraph ODY["Odyssey Compute"]
        odysseyp["Odyssey Parent"] -.- odysseysys
        odysseyp["Odyssey Parent"] -.- odysseyworkerN
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

