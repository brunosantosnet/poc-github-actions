provider "aws" {
  region = "us-east-1"
}

data "aws_ami" "myami" {
  most_recent      = true
  owners           = ["295845076046"]

  filter {
    name   = "name"
    values = ["myami*"]
  }

}

resource "aws_instance" "test" {
  ami           = data.aws_ami.myami.id
  instance_type = "t2.micro"
}
