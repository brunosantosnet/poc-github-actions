provider "aws" {
  region = "us-east-1"
}

data "aws_ami" "myami" {
  most_recent = true
  owners      = ["295845076046"]

  filter {
    name   = "name"
    values = ["myami*"]
  }

}

resource "aws_security_group" "http" {
  name   = "http"
  vpc_id = "vpc-0b892a2303a4b3b2b"

  ingress {
    from_port        = 0
    to_port          = 0
    protocol         = -1
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "http"
  }
}

resource "aws_instance" "test" {
  ami                    = data.aws_ami.myami.id
  instance_type          = "t2.micro"
  key_name               = "brunosantosnet"
  vpc_security_group_ids = aws_security_group.http.id
}
