provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "sandeep" {
  ami                     = var.ami
  instance_type           = var.instance_type
  vpc_security_group_ids  = ["sg-03dfc56f63b6d06c5"]

  tags = {
    Name                  = "sandeep"
  }
}

resource "aws_route53_record" "sandeep" {
  zone_id                 = var.zone_id
  name                    = var.dns_name
  ttl                     = 30
  type                    = "A"
  records                 = [aws_instance.sandeep.private_ip]
}

variable "zone_id" {
  default = "Z03369982K8R0OHQ4XJJV"
}

variable "dns_name" {
  default = "sandeep"
}

variable "instance_type" {
  default = "t3.micro"
}

variable "ami" {
  default = "ami-0220d79f3f480ecf5"
}
