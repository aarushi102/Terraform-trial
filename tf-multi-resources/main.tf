terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.71.0"
    }
  }
}

provider "aws" {
  # Configuration options
  region = "ap-south-1"
}

locals {
  project = "project-01"
}


resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "${local.project}-vpc"
  }
}

resource "aws_subnet" "my_subnet" {
  vpc_id = aws_vpc.my_vpc.id
  cidr_block = "10.0.${count.index}.0/24"
  count = 2
  tags = {
    Name = "${local.project}-subnet-${count.index}"
  }
}


resource "aws_instance" "main" {

count = length(var.ec2_config)
  ami = var.ec2_config[count.index].ami
  instance_type = var.ec2_config[count.index].instance_type
  subnet_id = element(aws_subnet.my_subnet[*].id, count.index % length(aws_subnet.my_subnet))

    tags = {
      Name = "${local.project}-instance-${count.index}"
    }

}
output "my_output" {
  value = aws_instance.main[0].id
}