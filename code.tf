resource "aws_instance" "instance" {
  count                   = 2

  ami                     = "ami-0220d79f3f480ecf5"
  instance_type           = "t3.micro"
  vpc_security_group_ids  = ["sg-080ee07db03cf22ab"]
  tags = {
    Name = var.components[count.index]
  }
}

resource "aws_route53_record" "dns" {
  count   = 2
  zone_id = "Z09354891N46GVLJSDZH0"
  ttl     = 5
  type    = "A"
  name    = "${var.components[count.index]}-dev"
  records = [aws_instance.instance[var.components[count.index]].private_ip]
}


variable components { default = [ "black", "white" ] }