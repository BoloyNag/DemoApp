provider "aws" {
  access_key = "ASIA5B47FFX2666QTHRM" ## replace with your access key
  secret_key = "DzEjvceDJ8lxwC7p6PQmt3xs911uSzeYwUcOmFmc" ## replace with your secret key
  token      = "FwoGZXIvYXdzEOj//////////wEaDBU9zH2eFzm0k9LGgyK2AXevtXlrq6hkuKZOi56PF3CxgPsWSql5f6Z0vQphlmNLF7C1umr5CVPUUhFE6Gqjwkt+zJxVIYu1xgncmgPCBg6kCzOKDFXFF4e9hc11OjR8V8COHtaEF3nxRDZ283vi3Q1HpriHR9yZFt5eP1lp+iEeC5W9KpVwPtlbJfhS1HkuCDlENqNtQm0MI6P/rDE1Po/TDyvj7V9vPSDg4YNs9YebvH3EdYDTUvvAU5ap/H32Q/UZreqkKLXa7LIGMi2Y0IhHQUPcPkBECdy75fb55o744c397BiPQkSAucv0wAQ6/v7Af9+lVOSQ1uw=" ## replace with token 
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
