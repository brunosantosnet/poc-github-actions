provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "test" {
  count         = 3
  ami           = "ami-0d5eff06f840b45e9"
  instance_type = "t2.micro"
}
