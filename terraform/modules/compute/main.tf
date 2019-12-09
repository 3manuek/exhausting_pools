resource "google_compute_instance" "node-compute" {
  name = var.instance_name
  machine_type = var.machine_type  #"n1-standard-4"
  zone = var.instance_zone #"europe-west4-b"

  depends_on = [var.vm_depends_on]

  tags = ["node"]

  boot_disk {
    initialize_params {
      image = var.image #"ubuntu-os-cloud/ubuntu-1804-lts"
      // image = "debian-cloud/debian-8"
      // size = "15"
    }
  }

  // Local SSD disk
  //  scratch_disk {
  //}

  network_interface {
    network = "default"

    access_config {
      // Ephemeral IP
    }
  }
  service_account {
    # email = "${google_service_account.hermes.email}"
    scopes = ["cloud-platform"]
  }

  metadata = {
    enable-oslogin = "TRUE"
    # startup-script = var.startup_script #"${data.template_file.default.rendered}" #"${data.template_cloudinit_config.datanode_config.rendered}"
    # startup_script = "${data.template_cloudinit_config.compute_config.rendered}"
    user-data = "${data.template_cloudinit_config.compute_config.rendered}"
  }
  # Copies the file file to /path/file
  # provisioner "file" {
  #   source      = var.source_file
  #   destination = var.dest_path
  # }
}
