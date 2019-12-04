resource "google_compute_instance" "node-compute" {
  name = var.instance_name
  machine_type = var.machine_type  #"n1-standard-4"
  zone = var.instance_zone #"europe-west4-b"

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

  metadata = {
    enable-oslogin = "TRUE"
    startup-script = var.startup_script #"${data.template_file.default.rendered}"
  }
  # Copies the file file to /path/file
  provisioner "file" {
    source      = var.source_file
    destination = var.dest_path
  }
}
