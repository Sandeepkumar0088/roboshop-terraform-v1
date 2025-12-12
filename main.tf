resource "aws_instance" "frontend" {
    ami = "ami-09c813fb71547fc4f"
    instance_type = "t3.micro"
    tags = {
    Name = "frontend"
    }
}

resource "aws_route53_record" "frontend-record" {
  zone_id = "Z09354891N46GVLJSDZH0"
  name    = "frontend-dev"
  type    = "A"
  ttl     = 30

  records = [aws_instance.frontend-record.private_ip]
}

resource "aws_instance" "mongodb" {
    ami = "ami-09c813fb71547fc4f"
    instance_type = "t3.micro"
    tags = {
    Name = "mongodb"
    }
}

resource "aws_route53_record" "mongodb-record" {
  zone_id = "Z09354891N46GVLJSDZH0"
  name    = "mongodb-dev"
  type    = "A"
  ttl     = 30

  records = [aws_instance.mongodb-record.private_ip]
}

