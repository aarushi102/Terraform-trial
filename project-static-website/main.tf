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

resource "aws_s3_bucket" "web-app-bucket" {
  bucket = "web-app-bucket-${random_id.rand_id.hex}"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_public_access_block" "webapp" {
  bucket = aws_s3_bucket.web-app-bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "example" {
  bucket = aws_s3_bucket.web-app-bucket.id
  policy = jsonencode(
    {
    Version =  "2012-10-17",
    Statement = [
        {
            Sid =  "AddPublicReadCannedAcl",
            Effect =  "Allow",
            Principal = "*"
            Action = "s3:GetObject",
            Resource = "${aws_s3_bucket.web-app-bucket.id}/",
        }
    ]
}
  )
}

resource "aws_s3_bucket_website_configuration" "webapp" {
  bucket = aws_s3_bucket.web-app-bucket.id

  index_document {
    suffix = "index.html"
  }
}


resource "aws_s3_object" "index_html" {
  bucket = aws_s3_bucket.web-app-bucket.bucket
  source = "./index.html"
  key = "index.html"
  content_type = "text/html"
}

resource "aws_s3_object" "styles_css" {
  bucket = aws_s3_bucket.web-app-bucket.bucket
  source = "./styles.css"
  key = "styles.css"
  content_type = "text/css"
  
}

output "name" {
  value = aws_s3_bucket_website_configuration.webapp.website_endpoint
}