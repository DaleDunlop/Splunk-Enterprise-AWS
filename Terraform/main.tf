terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.42.0"
    }
  }
}

provider "aws" {
  region = "eu-west-2"
}
resource "aws_instance" "splunk_server" {
  ami                         = "ami-0e26cf8ef2ab56e1c" #Specific for eu-west-2
  instance_type               = "t2.large"
  key_name                    = "splunk_server"
  tags                        = { Name = "splunk_server" }
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.splunk_server.id]
  subnet_id                   = aws_subnet.splunk_server.id
}

resource "aws_security_group" "splunk_server" {
  name_prefix = "splunk_group"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["<Your-IP>/32"]
    description = "SSH access from my IP"
  }

  ingress {
    from_port   = 8000
    to_port     = 8000
    protocol    = "tcp"
    cidr_blocks = ["<Your-IP>/32"]
    description = "Splunk web access from my IP"
  }
}

resource "aws_subnet" "splunk_server" {
  vpc_id     = "vpc-086e70d08326f6d96"
  cidr_block = "172.31.48.0/20"
}

output "splunk_server_public_ip" {
  value = aws_instance.splunk_server.public_ip
}
