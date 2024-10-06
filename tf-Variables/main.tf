terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.70.0"
    }
  }
}

provider "aws" {
  # Configuration options
  region = "ap-south-1"
}

resource "aws_instance" "name" {
    ami = "ami-0522ab6e1ddcc7055"
    instance_type = var.aws_instance_type

    root_block_device {
      delete_on_termination = true
      volume_size = var.ec2_config.v_size
      volume_type = var.ec2_config.v_type
    }

    tags = merge(var.additional_tags, {
      Name = "Sample server"
    })
  
}