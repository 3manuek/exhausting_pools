resource "google_compute_disk" "default" {
  name  = var.instance_name
  type  = var.extra_disk_type
  zone  = var.instance_zone
  image = var.image
  size = var.extra_disk_size
  labels = {
    environment = "testing"
  }
}

resource "google_compute_attached_disk" "default" {
  disk     = google_compute_disk.default.self_link
  instance = google_compute_instance.database-compute.self_link
}

resource "google_compute_instance" "database-compute" {
  name         = var.instance_name
  machine_type = var.machine_type #"n1-standard-4"
  zone         = var.instance_zone #"europe-west4-b"

  tags = [""]

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

  metadata = {
    enable-oslogin = "TRUE"
    startup-script =  var.startup_script # "${data.template_file.default.rendered}"
    #path.module
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral IP
    }
  }

  # Copies the myapp.conf file to /etc/myapp.conf
  provisioner "file" {
    source      = var.source_file
    destination = var.dest_path
  }

}
