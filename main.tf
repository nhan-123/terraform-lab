terraform {
  backend "s3" {
    bucket         = "terraform-734557485568-s3-backend"
    key            = "terraform-jenkins"
    region         = "us-east-2"
    encrypt        = true
    role_arn       = "arn:aws:iam::734557485568:role/Terraform-734557485568S3BackendRole"
    dynamodb_table = "terraform-734557485568-s3-backend"
  }
}

provider "aws" {
  region = "us-east-2"
}

data "aws_ami" "ami" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  owners = ["7345-5748-5568"]
}

resource "aws_instance" "server" {
  ami           = data.aws_ami.ami.id
  instance_type = "t3.micro"

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "Server"
  }
}

output "public_ip" {
  value = aws_instance.server.public_ip
}