variable "instance_zone" {
}

variable "instance_name" {
}

variable "machine_type" {
}

# variable "extra_disk_size" {  
# }

# variable "extra_disk_type" {  
# }

variable "image" {
  
}


variable "dest_path" {
  default = ""
}

variable "vm_depends_on" {
  type    = any
  default = null
}

variable "mode" {}

variable "db_instance_name" {}

variable "tags" {}

variable "replicas" {
  default = "1"
}
