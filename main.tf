provider "aws" {
  region = "${var.aws_region}"
}

resource "aws_instance" "myInstanceAWS" {
  count = "${var.instance_count}"
  instance_type = "${var.instance_type}"
  ami = "${var.ami_id}"
  key_name = "Sing"
  subnet_id = "subnet-6e08bd08"
}

resource "null_resource" "ConfigureAnsibleLabelVariable" {
  provisioner "local-exec" {
    command = "echo [${var.dev_host_label}:vars] > hosts"
  }
  provisioner "local-exec" {
    command = "echo ansible_ssh_user=${var.ssh_user_name} >> hosts"
  }
  provisioner "local-exec" {
    command = "echo ansible_ssh_private_key_file=${var.ssh_key_path} >> hosts"
  }
  provisioner "local-exec" {
    command = "echo [${var.dev_host_label}] >> hosts"
  }
}

resource "null_resource" "ProvisionRemoteHostsIpToAnsibleHosts" {
  count = "${var.instance_count}"
  connection {
    type = "ssh"
    user = "${var.ssh_user_name}"
    host = "${element(aws_instance.myInstanceAWS.*.public_ip, count.index)}"
    private_key = "${file("${var.ssh_key_path}")}"
  }

  provisioner "local-exec" {
    command = "echo ${element(aws_instance.myInstanceAWS.*.public_ip, count.index)} >> hosts"
  }
}
resource "null_resource" "ModifyApplyAnsiblePlayBook" {
  provisioner "local-exec" {
    command = "sed -i -e '/hosts:/ s/: .*/: ${var.dev_host_label}/' play.yml"
  }

  depends_on = ["null_resource"."ProvisionRemoteHostsIpToAnsibleHosts"]
}
