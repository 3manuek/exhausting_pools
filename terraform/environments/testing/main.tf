module "postgres_instance" {
  source = "../../modules/database"
  instance_name = "postgres-node"
  machine_type = "n1-standard-16" # 16 cores 60 RAM
  instance_zone = "europe-west4-b"
  extra_disk_size = "200"
  extra_disk_type = "pd-ssd"
  image = "ubuntu-os-cloud/ubuntu-1604-lts"
  startup_script = "${file("${path.module}/../../provision/postgres.sh")}"
  # dest_path = "/tmp"
}

# module "pgbouncer_instance" {
#   source = "../../modules/compute"
#   instance_name = "pgbouncer-node"
#   machine_type = "n1-standard-4"
#   instance_zone = "europe-west4-b"
#   image = "ubuntu-os-cloud/ubuntu-1804-lts"
#   startup_script = "${file("../../provision/pgbouncer.sh")}"
# }


module "odyssey_instance" {
  source = "../../modules/compute"
  instance_name = "odyssey-node"
  mode = "odyssey"
  machine_type = "n1-standard-4" # 4 cores 15 GB
  instance_zone = "europe-west4-b"
  image = "ubuntu-os-cloud/ubuntu-1604-lts"
  dest_path = "/tmp"
  vm_depends_on = [module.postgres_instance]
  db_instance_name = "postgres-node" # we assume both are in the same _zone_
  tags = "odyssey"
}


module "client_instance" {
  source = "../../modules/compute"
  instance_name = "client-node"
  replicas = 2
  mode = "client"
  machine_type = "n1-standard-8" # 4 cores 15 GB
  instance_zone = "europe-west4-b"
  image = "ubuntu-os-cloud/ubuntu-1604-lts"
  dest_path = "/tmp"
  vm_depends_on = [module.odyssey_instance]
  db_instance_name = "client-node" # we assume both are in the same _zone_
  tags = "client"
}