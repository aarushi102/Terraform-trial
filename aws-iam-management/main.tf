
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
  region = "ap-south-1"
}

locals {
  users_data = yamldecode(file("./users.yaml")).users
}

output "value" {
  value = local.users_data[*].username
}

resource "aws_iam_user" "main" {
  for_each = toset(local.users_data[*].username)
  name = each.value
}