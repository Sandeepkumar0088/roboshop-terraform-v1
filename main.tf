resource "aws_instance" "frontend" {
    ami = "ami-09c813fb71547fc4f"
    instance_type = "t3.micro"
    vpc_security_group_ids= [ "sg-039df2e97e51ebc17" ]
    tags = {
    Name = "frontend"
    }
}

resource "aws_route53_record" "frontend" {
  zone_id = "Z09354891N46GVLJSDZH0"
  name    = "frontend-dev"
  type    = "A"
  ttl     = 30

  records = [aws_instance.frontend.private_ip]
}

resource "aws_instance" "mongodb" {
    ami = "ami-09c813fb71547fc4f"
    instance_type = "t3.micro"
    vpc_security_group_ids= [ "sg-039df2e97e51ebc17" ]
    tags = {
    Name = "mongodb"
    }
}

resource "aws_route53_record" "mongodb" {
  zone_id = "Z09354891N46GVLJSDZH0"
  name    = "mongodb-dev"
  type    = "A"
  ttl     = 30

  records = [aws_instance.mongodb.private_ip]
}

resource "aws_instance" "catalogue" {
    ami = "ami-09c813fb71547fc4f"
    instance_type = "t3.micro"
    vpc_security_group_ids= [ "sg-039df2e97e51ebc17" ]
    tags = {
    Name = "catalogue"
    }
}

resource "aws_route53_record" "catalogue" {
  zone_id = "Z09354891N46GVLJSDZH0"
  name    = "catalogue-dev"
  type    = "A"
  ttl     = 30

  records = [aws_instance.catalogue.private_ip]
}

