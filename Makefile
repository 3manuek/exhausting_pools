SHELL=/bin/sh
# .PHONY: apply plan
DEF_ENVIRONMENT=testing #I'll regret this some day

# DEF_REGION=us-east-1

ifndef ENV
	ENV=$(DEF_ENVIRONMENT)
endif

# terraform init -backend-config=backend.hcl
# We need to concat backendConfig + backend_connstr
define backendConfig
workspaces { name = "$${ENV}" }
organization = "OnGres"

endef

# .PHONY: setup

%:
	source .env &&  cd terraform/environments/$(ENV) && terraform $*

# setup:
# 	source .env && cd terraform/environments/$(ENV) && \
# 	terraform workspace new $(ENV)
# gcloud auth activate-service-account --key-file=$HOME/.gcloud/postgresql-support-dev-terraform-admin.json
.PHONY: init
init:
	source .env && export TF_WORKSPACE=$(ENV) && gcloud config set project $${PROJECT} && \
	echo "$${BACKEND_CONNSTR}" > terraform/environments/$(ENV)/$(ENV).tfvars && \
	cd terraform/environments/$(ENV) && \
	terraform init \
		-backend-config=$(ENV).tfvars || terraform workspace new $(ENV) && \
	terraform init \
		-backend-config=$(ENV).tfvars
	# welcome to terraform 0.12
	# this could be fixed by defining an hcl based configuration for having the 
	# connstring and the workspaces definition as in https://www.terraform.io/docs/backends/types/remote.html#example-configuration-using-cli-input
