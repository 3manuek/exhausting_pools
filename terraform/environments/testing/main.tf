module "postgres_instance" {
  source = "../../modules/database"
  instance_name = "postgres-node"
  machine_type = "n1-standard-16" # 16 cores 60 RAM
  instance_zone = "europe-west4-b"
  extra_disk_size = "200"
  extra_disk_type = "pd-ssd"
  #image = "ubuntu-os-cloud/ubuntu-1804-lts"
  image = "ubuntu-os-cloud/ubuntu-1604-lts"
  startup_script = "${file("${path.module}/../../provision/postgres.sh")}"
}

# module "pgbouncer_instance" {
#   source = "../../modules/compute"
#   instance_name = "pgbouncer-node"
#   machine_type = "n1-standard-4"
#   instance_zone = "europe-west4-b"
#   image = "ubuntu-os-cloud/ubuntu-1804-lts"
#   startup_script = "${file("../../provision/pgbouncer.sh")}"
# }


module "oddysey_instance" {
  source = "../../modules/compute"
  instance_name = "oddysey-node"
  machine_type = "n1-standard-4" # 4 cores 15 GB
  instance_zone = "europe-west4-b"
  #image = "ubuntu-os-cloud/ubuntu-1804-lts"
  image = "ubuntu-os-cloud/ubuntu-1604-lts"
  startup_script = "${file("${path.module}/../../provision/odyssey.sh")}"
  source_file = "${path.module}/../../files/odyssey_binary.zip"
  dest_path = "/tmp"
}
