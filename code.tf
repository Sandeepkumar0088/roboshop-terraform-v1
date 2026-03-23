terraform {
  required_providers {
    null = {
      source  = "hashicorp/null"
      version = "3.2.4"
    }
  }
}
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


resource "null_resource" "ansible" {
  for_each  = var.components

  depends_on = [aws_route53_record.dns,aws_instance.instance]

  provisioner "remote-exec" {
    connection {
      type = "ssh"
      user = "ec2"
      password = ""
      host     = aws_instance.instance[each.key].private_ip
    }
    inline = [
      "pip3.13 install ansible",
      "amsible-pull -i localhost, -U githuburl main.yml -e component=${each.key} -e env=dev"
    ]
  }
}