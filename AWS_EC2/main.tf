
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.68.0"
    }
  }
}

provider "aws" {
  # Configuration options
  region = var.region
}


resource "aws_instance" "myserver" {
    ami = "ami-0522ab6e1ddcc7055"
    instance_type = "t3.micro"

    tags = {
      Name = "Optional server"
    }

  
}