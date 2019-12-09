
# data "template_file" "compute_cloud_init" {
#   template = "${file("${path.module}/templates/cloud-config.yml.tpl")}"

#   vars {
#     entrypoint          = "${base64encode(file("${path.module}/files/${var.config["action"]}/datanode/entrypoint.sh"))}"
#     finish              = "${base64encode(file("${path.module}/files/${var.config["action"]}/datanode/finish.sh"))}"
#     libdefault          = "${base64encode(file("${path.module}/lib/default.sh"))}"
#     fsscript            = "${base64encode(file("${path.module}/lib/${var.config["fs"]}.sh"))}"
#     dbenginescript      = "${base64encode(file("${path.module}/lib/${var.config["dbengine"]}.sh"))}"
#     triggerscript       = "${base64encode(file("${path.module}/files/${var.config["action"]}/client/${var.config["trigger_script"]}.sh"))}"
#     device_name         = "${var.config["device_name"]}"
#     datadir             = "${var.config["datadir"]}"
#     fs                  = "${var.config["fs"]}"
#     dbengine            = "${var.config["dbengine"]}"
#     sshuser             = "${var.globalconfig["sshuser"]}"
#     resultsdir          = "${local.pretags["Resultsdir"]}"
#   }
# }

# data "template_cloudinit_config" "compute_config" {
#   gzip          = true
#   base64_encode = true


#   part {
#     content_type = "text/cloud-config"
#     content      = "${data.template_file.compute_cloud_init.rendered}"
#   }
# }


data "template_file" "compute_template" {
    template = "${file("${path.module}/templates/cloud-config.yml.tpl")}"

    vars = {
        mode = var.mode
        lib = "${base64encode(file("${path.module}/files/lib.sh"))}"
        triggerscript =  "${base64encode(file("${path.module}/files/${var.mode}.sh"))}"
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