module "postgres_instance" {
  source = "../../modules/database"
  instance_name = "postgres-node"
  machine_type = "n1-standard-4"
  instance_zone = "europe-west4-b"
  extra_disk_size = "200"
  extra_disk_type = "pd-ssd"
  image = "ubuntu-os-cloud/ubuntu-1804-lts"
  startup_script = "${file("../provision/postgres.sh")}"
}


module "pgbouncer_instance" {
  source = "../../modules/compute"
  instance_name = "pgbouncer-node"
  machine_type = "n1-standard-4"
  instance_zone = "europe-west4-b"
  image = "ubuntu-os-cloud/ubuntu-1804-lts"
  startup_script = "${file("../provision/pgbouncer.sh")}"
}


module "oddysey_instance" {
  source = "../../modules/compute"
  instance_name = "oddysey-node"
  machine_type = "n1-standard-4"
  instance_zone = "europe-west4-b"
  image = "ubuntu-os-cloud/ubuntu-1804-lts"
  startup_script = "${file("../provision/odyssey.sh")}"
}