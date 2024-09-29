terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.68.0"
    }

  }

}

provider "aws" {
  region = "ap-south-1"
}


# Create a VPC
resource "aws_vpc" "my-vpc" {
    cidr_block = "10.0.0.0/16"
    tags = {
        Name = "my-vpc"
    }
  
}

# private subnet

resource "aws_subnet" "private-subnet" { 
    cidr_block = "10.0.1.0/24"
    vpc_id  = aws_vpc.my-vpc.id
    tags = {
      Name = "private subnet"
    }

}

resource "aws_subnet" "public-subnet" { 
    cidr_block = "10.0.2.0/24"
    vpc_id  = aws_vpc.my-vpc.id
    tags = {
      Name = "public subnet"
    }

}

# internet gateway

resource "aws_internet_gateway" "my-igw" {
    vpc_id = aws_vpc.my-vpc.id
    tags = {
      Name = "My internet gateway"
    }
  
}

resource "aws_route_table" "my-rt" {
    vpc_id = aws_vpc.my-vpc.id

    route{
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.my-igw.id

    }
  
}

resource "aws_route_table_association" "public_subnet" {
    route_table_id = aws_route_table.my-rt.id
    subnet_id = aws_subnet.public-subnet.id
  
}

resource "aws_instance" "myserver" {
    ami = "ami-0522ab6e1ddcc7055"
    instance_type = "t3.micro"
    subnet_id = aws_subnet.public-subnet.id
    tags = {
      Name = "Optional server"
    }

  
}