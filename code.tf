resource "aws_instance" "frontend" {
  count                   = 6

  ami                     = ""
  instance_type           = ""
  vpc_security_group_ids  = [""]
  tags = {
    Name = var.components[count.index][key]
  }
}

resource "aws_route53_record" "dns" {
  zone_id = ""
  ttl     = 5
  type    = "A"
  name    = "${var.components[count.index][value]}-dev"
  records = [aws_instance.frontend.private_ip]
}


variable components  {
    default = {
      frontend  = "t3.micro"
      cart      = "t3.micro"
      user      = "t3.micro"
      shipping  = "t3.micro"
      payment   = "t3.micro"
      catalogue = "t3.micro"
      }
}