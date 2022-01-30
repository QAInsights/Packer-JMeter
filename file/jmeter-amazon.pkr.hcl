source "amazon-ebs" "jmeter" {
  region          = "us-east-2"
  instance_type   = "t2.small"
  ami_name        = "jmeter_{{timestamp}}"
  ssh_username    = "ec2-user"
  skip_create_ami = false
  source_ami_filter {
    filters = {
      virtualization-type = "hvm"
      name                = "amzn2-ami-kernel-5.10-hvm-*-x86_64-gp2"
      root-device-type    = "ebs"
    }
    owners      = ["137112412989"]
    most_recent = true
  }
}

build {
  sources = [
    "source.amazon-ebs.jmeter"
  ]

  provisioner "file" {
    source      = "install_jmeter.sh"
    destination = "/tmp/install_jmeter.sh"
  }
  provisioner "shell" {
    inline = ["sudo bash /tmp/install_jmeter.sh"]
  }


}

