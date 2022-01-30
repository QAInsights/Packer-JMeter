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
  provisioner "shell" {
    environment_vars = [
      "JMETER_VERSION=${var.jmeter_version}",
      "JMETER_CMDRUNNER_VERSION=${var.jmeter_cmdrunner_version}",
      "JMETER_PLUGINS_MANAGER_VERSION=${var.jmeter_plugins_manager_version}",
      "JMETER_HOME=/home/ec2-user",
      "JMETER_DOWNLOAD_URL=https://dlcdn.apache.org//jmeter/binaries/apache-jmeter-${var.jmeter_version}.tgz",
      "JMETER_CMDRUNNER_DOWNLOAD_URL=http://search.maven.org/remotecontent?filepath=kg/apc/cmdrunner/${var.jmeter_cmdrunner_version}/cmdrunner-${var.jmeter_cmdrunner_version}.jar",
      "JMETER_PLUGINS_MANAGER_DOWNLOAD_URL=https://repo1.maven.org/maven2/kg/apc/jmeter-plugins-manager/${var.jmeter_plugins_manager_version}/jmeter-plugins-manager-${var.jmeter_plugins_manager_version}.jar",
      "JMETER_PLUGINS=jpgc-casutg,jpgc-functions"
    ]
    script = "install_jmeter.sh"
  }

}

variable "jmeter_version" {
  default = "5.4.3"
}
variable "jmeter_cmdrunner_version" {
  default = "2.2"
}
variable "jmeter_plugins_manager_version" {
  default = "1.7"
}