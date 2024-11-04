
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

resource "aws_iam_user_login_profile" "main" {
  for_each = aws_iam_user.main
  user = each.value.name
  password_length = 12

  lifecycle {
    ignore_changes = [ 
      password_length,
      password_reset_required,
      pgp_key,
     ]
  }
}