SHELL=/bin/sh
# .PHONY: apply plan
DEF_ENVIRONMENT=testing
ABSPATH=$(abspath .)
ANSIBLE=$(ABSPATH)/ansible
ANSIBLE_INVENTORY=$(ANSIBLE)/inventory
ANSIBLE_PLAYBOOKS_DIR := $(abspath .)/ansible
ANSIBLE_CONFIG=$(ANSIBLE)/ansible.cfg
CREDS=${HOME}/.gcloud/postgresql-support-dev-terraform-admin.json
# ^ define in env, should not be mandatory


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

define ansibleconf
[inventory]
enable_plugins = script, gcp_compute

[all:vars]
ansible_user=sa_
endef

%:
	source .env &&  cd terraform/environments/$(ENV) && terraform $*

.PHONY: clean
clean:
	source .env &&  cd terraform/environments/$(ENV) && \
	terraform destroy && terraform destroy -auto-approve
	
.PHONY: setup
setup:
	gcloud auth activate-service-account --key-file=${CREDS} && \
	gcloud iam service-accounts describe `jq -r '.client_email' ${CREDS}` --format='value(uniqueId)' && \
	gcloud auth application-default login


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


.PHONY: gcp-inventory
gcp-inventory:
	export DYLD_LIBRARY_PATH=/usr/local/opt/openssl/lib:${DYLD_LIBRARY_PATH} && \
	 source .env && export TF_WORKSPACE=$(ENV) && gcloud config set project $${PROJECT} && \
	ANSIBLE_CONFIG=$(ANSIBLE_CONFIG) &&  \
	ansible-inventory -i $(ANSIBLE)/gcp.yaml --list --yaml --output=$(ANSIBLE)/inventory/hosts.yaml

.PHONY: ping
ping:
	export DYLD_LIBRARY_PATH=/usr/local/opt/openssl/lib:${DYLD_LIBRARY_PATH} && \
	ANSIBLE_SSH_EXECUTABLE=$(ABSPATH)/ssh && ANSIBLE_CONFIG=$(ANSIBLE_CONFIG) &&\
	 ansible  -m ping --inventory-file=${ANSIBLE_INVENTORY}/hosts.yaml  all

.PHONY: odyssey-conf
odyssey-conf:
	export DYLD_LIBRARY_PATH=/usr/local/opt/openssl/lib:${DYLD_LIBRARY_PATH} && \
	ANSIBLE_SSH_EXECUTABLE=$(ABSPATH)/ssh && ansible-playbook -l odyssey --inventory-file=${ANSIBLE_INVENTORY}/hosts.yaml ${ANSIBLE_PLAYBOOKS_DIR}/odyssey_configuration.yaml