packer {
  required_plugins {
    amazon = {
      version = ">= 0.0.1"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "ubuntu" {
  ami_name      ="myami-${formatdate("YYYYMMDDhhmm", timeadd(timestamp(), "-3h"))}"
  instance_type = "t2.micro"
  region        = "us-east-1"
  tags          = {
    name = "veeam"
  }
  source_ami_filter {
    filters = {
      name                = "ubuntu/images/*ubuntu-xenial-16.04-amd64-server-*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["099720109477"]
  }
  ssh_username = "ubuntu"
}


build {
  sources = [
    "source.amazon-ebs.ubuntu"
  ]

  provisioner "shell" {
    inline = [
      "echo Update packages",
      "apt-get update -y",
      "apt-get install python3-pip -y",
      "echo Install uvicorn package",
      "pip3 install uvicorn",
      "echo Install fastapi package",
      "pip3 install fastapi",
      "echo Install requests package",
      "pip3 install requests",
      "mkdir /app",
      "cd /app",
    ]
  }

  provisioner "file" {
    source      = "main.py"
    destination = "/app/main.py"
  }
  provisioner "file" {
    source      = "app.service"
    destination = "/etc/systemd/system/app.service"
  }

}
