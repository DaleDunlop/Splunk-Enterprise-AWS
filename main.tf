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
  ami = "splunk_AMI_9.0.9_2024-03-28_20-53-35-7b65de6c-5006-4ca2-bd75-fdba95ae5d9d
ami-0e26cf8ef2ab56e1c"
  instance_type = "t2.micro"
  key_name = "splunk_server"
  tags = {
    Name = "splunk_server"
  }
  associate_public_ip_address = true
  vpc_security_group_ids = ["aws_security_group.splunk_server.id"]
  subnet_id = "aws_subnet.splunk_server.id"
}

resource "aws_security_group" "splunk_server" {
    name_prefix = "splunk_group"

    ingress {
        from_port = 22 # ssh port
        to_port =  22
        protocol = "tcp"
        cidr_blocks = ["<your-IP>/32"]
    }

    ingress {
        from_port = 8000 # splunk web port
        to_port =  8000
        protocol = "tcp"
        cidr_blocks = ["<your-IP>/32"]
    }
}

resource "aws_subnet" "splunk_server" {
    vpc_id = ""
    cidr_block = "10.0.0.0/24"
}