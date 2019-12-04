
# Instance Id
# output "pgbouncer_instance_id" {
#   value = "${module.pgbouncer_instance.compute_instance_id}"
# }

output "odyssey_instance_id" {
  value = "${module.oddysey_instance.compute_instance_id}"
}

output "postgres_instance_id" {
  value = "${module.postgres_instance.database_instance_id}"
}

# IP
# output "pgbouncer_instance_ip" {
#   value = ["${module.pgbouncer_instance.compute_instance_ip}"]
# }

output "odyssey_instance_ip" {
  value = ["${module.oddysey_instance.compute_instance_ip}"]
}

output "postgres_instance_ip" {
  value = ["${module.postgres_instance.database_instance_ip}"]
}

