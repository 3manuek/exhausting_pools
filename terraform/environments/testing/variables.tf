variable "region" {
  default = "europe-west4"
}

variable "ssh_public_key_filepath" {
  description = "Filepath for the ssh public key"
  type = string

  default = "~/.ssh/gcp.pub"
}


variable "project" {
    default = "postgresql-support-dev"
}


variable "machine_type" {
    default = "n1-standard-1"
}

variable "metadata" {
    default = {}
}

variable "image" {
   # XXX: Use Teleport or a decent bastion image.
   #default = "ubuntu-1804-bionic-v20191021"
  default = "ubuntu-1604-xenial-v20191113" # gitlab's version
}

variable "dest_path" {
  default = ""
}
