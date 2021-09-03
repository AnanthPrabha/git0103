provider "aws" {
  region = "ap-southeast-1"
}

resource "aws_default_vpc" "default" {
  tags = {
    Name = "Default VPC"
  }
}

resource "aws_security_group" "newsg" {
  description = "ALL TCP"
  vpc_id      = aws_default_vpc.default.id

  ingress {
      description      = "TLS from VPC"
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }

 ingress {
      description      = "TLS from VPC"
      from_port        = 80
      to_port          = 80
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }


  egress {
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }
}


resource "aws_instance" "mytask" {
  ami           = "ami-0ae0964841ce837fd"
  instance_type = "t2.micro"
  vpc_security_group_ids = ["${aws_security_group.newsg.id}"]
  key_name      = "Sing"
  tags = {
    Name = "task"
  }

  provisioner "local-exec" {
    command = "echo ${aws_instance.mytask.public_ip} > inventory.txt"
}
}

  output "PublicDns"{
  value = aws_instance.mytask.public_dns
}
