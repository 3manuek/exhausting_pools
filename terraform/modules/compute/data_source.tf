
data "template_file" "compute_template" {
    template = "${file("${path.module}/templates/cloud-config.yml.tpl")}"

    vars = {
        mode = var.mode
        lib = "${base64encode(file("${path.module}/files/lib.sh"))}"
        triggerscript =  "${base64encode(file("${path.module}/files/${var.mode}.sh"))}"
        benchmark_test =  "${base64encode(file("${path.module}/files/benchmark_test.sh"))}"
        # triggerscript =  "${file("${path.module}/files/${var.mode}.sh")}"
    }
}

data "template_cloudinit_config" "compute_config" {
    gzip = false
    base64_encode = false

    part {
        content_type = "text/cloud-config"
        content      = data.template_file.compute_template.rendered
    }

}

data "google_compute_instance" "database" {
  name = var.db_instance_name
#   zone = "us-central1-a"
  zone = var.instance_zone
}