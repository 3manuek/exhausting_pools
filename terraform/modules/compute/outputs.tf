output "compute_instance_id" {
    value = ["${google_compute_instance.node-compute.*.instance_id}"]
}

output "compute_instance_ip" {
    value = ["${google_compute_instance.node-compute.*.network_interface.0.network_ip}"]
}

output "compute_external_ip" {
  value = ["${google_compute_instance.node-compute.*.network_interface.0.access_config.0.nat_ip}"]
}
