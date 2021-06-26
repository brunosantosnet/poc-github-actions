provider "aws" {
  region = "us-east-1"
}

data "aws_ami" "myami" {
  executable_users = ["self"]
  most_recent      = true
  owners           = ["self"]

  filter {
    name   = "name"
    values = ["veeam-*"]
  }

}

resource "aws_instance" "test" {
  ami           = data.aws_ami.myami.id
  instance_type = "t2.micro"
}
