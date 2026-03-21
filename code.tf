resource "aws_instance" "instance" {
  for_each                = var.components

  ami                     = "ami-0220d79f3f480ecf5"
  instance_type           = "t3.micro"
  vpc_security_group_ids  = ["sg-080ee07db03cf22ab"]
  tags = {
    Name = each.key
  }
}

resource "aws_route53_record" "dns" {
  for_each  = var.components

  zone_id   = "Z09354891N46GVLJSDZH0"
  ttl       = 5
  type      = "A"
  name      = "${each.key}-dev"
  records   = [aws_instance.instance[each.key].private_ip]
}


variable components {
  default = {
    black = "t3.micro"
    white = "t3.micro"
  }
}