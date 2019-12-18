SHELL=/bin/sh
# .PHONY: apply plan
DEF_ENVIRONMENT=testing
ABSPATH=$(abspath .)
ANSIBLE=ansible
ANSIBLE_INVENTORY=$(ANSIBLE)/inventory
ANSIBLE_PLAYBOOKS_DIR := $(abspath .)/ansible
# DEF_REGION=us-east-1

ifndef ENV
	ENV=$(DEF_ENVIRONMENT)
$(info WARNING you have not declared ENV, using $(DEF_ENVIRONMENT))
endif


## Tested, but it didn't work as expected.
# terraform init -backend-config=backend.hcl
# We need to concat backendConfig + backend_connstr
# define backendConfig
# workspaces { name = "$${ENV}" }
# organization = "OnGres"

# endef


%:
	source .env &&  cd terraform/environments/$(ENV) && terraform $*

# .PHONY: setup
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

.PHONY: inventory
inventory:
	/bin/sh ansible_hosts_inventory.sh

odyssey-conf:
	ansible-playbook -l odyssey --inventory-file=${ANSIBLE_INVENTORY}/hosts.yaml ${ANSIBLE_PLAYBOOKS_DIR}/odyssey_configuration.yaml