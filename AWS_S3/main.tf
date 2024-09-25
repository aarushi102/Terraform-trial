terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.68.0"
    }

    random = {
      source = "hashicorp/random"
      version = "3.6.3"
    }

  }
}

resource "random_id" "rand_id" {
  byte_length = 8
  
}

provider "aws" {
  region = "ap-south-1"
}

resource "aws_s3_bucket" "never-used-beforebucket" {
  bucket = "my-tf-test-bucket-never-${random_id.rand_id.hex}"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

resource "aws_s3_object" "myobjectname" {
  bucket = aws_s3_bucket.never-used-beforebucket.bucket
  source = "./myfile.txt"
  key = "mydata.txt"

}

output "name" {
  value = random_id.rand_id.hex
}