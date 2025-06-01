# resource "local_file" "my_file" {
#   filename = "automate.txt"
#   content = "This is the automated file"
# }

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.0.0-beta2"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

resource "aws_s3_bucket" "mybucket" {
    bucket = "bucket10625"

  
}