output "database_instance_id" {
    value = ["${google_compute_instance.database-compute.instance_id}"]
}

output "database_instance_ip" {
    value = ["${google_compute_instance.database-compute.network_interface.*.network_ip}"]
}