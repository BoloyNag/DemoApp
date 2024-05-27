provider "aws" {
  access_key = "ASIA5B47FFX265VTLWF2" ## replace with your access key
  secret_key = "hkHG3AFhh6KPw5l2XydfbrCEGL8ZTwG1nzVy8SND" ## replace with your secret key
  token      = "FwoGZXIvYXdzEHAaDOxNYdWeJ9qV92IhOCK2AfMjYMNPvaH9/rO6/oEOJocZKDj2tZYCmoLFY4AUqzqFDUNlUccqR3ZOGpbN2heqwdX0JxNwxewLMudpkdFlGOVvjGDrmv6i73Yp6De9rj640uem4iIHHG/AS/AoIE0G98m3UfSiIBgnhxoH75dTne8Ro1LzwKHULBhtMypdXiuXhkETqiBef+1i4PQgAn7GuhBXQn+VHNpTpY687a++UraoQIeyuCdq717xKwZ+Gq4JrsVgNhZFKNSp0rIGMi2TY8OJk52Fj19gusrm+eEYePAdB9bJgc/qyzOVAxADyKTfMI1mPsJOFj96VzQ=" ## replace with token 
  region     = "us-east-1"
}

resource "aws_key_pair" "deployer" {
  key_name   = "keypair"
  public_key = file("${path.module}/keypair.pub")
}


resource "aws_security_group" "demo" {
  name        = "demo_sg"
  description = "Demo security group"

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
}

resource "aws_instance" "jenkins_server" {
  ami           = "ami-04b70fa74e45c3917"  ## Ubuntu machine AMI
  instance_type = "t2.micro"
  key_name = aws_key_pair.deployer.key_name
  vpc_security_group_ids = [aws_security_group.demo.id]
  tags = {
    Name = "jenkins_server"
  }
  
  user_data = <<-EOF
		#!/bin/bash -v
		apt-get update
		apt-get install -y ansible
		git clone https://github.com/BoloyNag/DemoApp.git
		EOF
}
