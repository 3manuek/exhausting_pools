output "compute_instance_id" {
    value = ["${google_compute_instance.node-compute.*.instance_id}"]
}

output "compute_instance_ip" {
    value = ["${google_compute_instance.node-compute.network_interface.*.network_ip}"]
}