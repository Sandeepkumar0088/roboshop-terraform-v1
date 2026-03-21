resource "aws_instance" "instance" {
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
  records = [aws_instance.instance[var.components[count.index][key]].private_ip]
}


variable components  {
    default = {
      black  = "t3.micro"
      white  = "t3.micro"

      }
}