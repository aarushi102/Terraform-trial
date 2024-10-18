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

for_each = var.ec2_map
  ami = each.value.ami
  instance_type = each.value.instance_type

  

    tags = {
      Name = "${local.project}-instance-${each.key}"
    }

}
output "my_output" {
  value = aws_instance.main[0].id
}