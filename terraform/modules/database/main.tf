resource "google_compute_disk" "default" {
  name  = var.instance_name
  type  = var.extra_disk_type
  zone  = var.instance_zone
  image = var.image
  size  = var.extra_disk_size
  labels = {
    environment = "testing"
  }
}

# resource "google_compute_attached_disk" "default" {
#   disk     = google_compute_disk.default.self_link
#   instance = google_compute_instance.database-compute.self_link
# }

resource "google_compute_instance" "database-compute" {
  name         = var.instance_name
  machine_type = var.machine_type #"n1-standard-4"
  zone         = var.instance_zone #"europe-west4-b"

  tags = ["database"]

  boot_disk {
    initialize_params {
      image = var.image 
      #"ubuntu-os-cloud/ubuntu-1804-lts"
      // image = "debian-cloud/debian-8"
      // size = "15"
    }
  }

  # Using this new block, Terraform does not work properly on destroy
  # attached_disk {
  #   source = google_compute_disk.default.self_link
  # }
  # The / partition, otherwise the disk will be the roo
  # scratch_disk {
  #   interface = "SCSI"
  # }

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
  service_account {
    # email = "${google_service_account.hermes.email}"
    scopes = ["cloud-platform"]
  }

  lifecycle {
    ignore_changes = [attached_disk]
  }

}


