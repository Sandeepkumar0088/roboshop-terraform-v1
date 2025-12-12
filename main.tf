resource "aws_instance" "frontend" {
    ami = "ami-09c813fb71547fc4f"
    instance_type = "t3.micro"
    tags = {
    Name = "HelloWorld"
    }
}

resource "aws_route53_record" "frontend" {
  zone_id = "Z09354891N46GVLJSDZH0"
  name    = "frontend-dev"
  type    = "A"
  ttl     = 30

  records = [aws_instance.frontend.private_ip]

  depends_on = [aws_instance.web]
}