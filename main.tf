provider "aws" {
  region     = "us-east-1"
}


variable "subnet_cidr_block" {
  description = "subnet cidr block"
  type = string
}

variable "vpc_cidr_block" {
  description = "vpc cidr block"
  type = string
}


resource "aws_vpc" "my-vpc" {
  cidr_block = var.vpc_cidr_block
  tags = {
    Name = "myVPC"
  }
}

resource "aws_subnet" "my-subnet" {
  vpc_id            = aws_vpc.my-vpc.id
  cidr_block        = var.subnet_cidr_block
  availability_zone = "us-east-1a"
  tags = {
    Name = "my-subnet"
  }
}



output "dev-vpc-id" {
  value = aws_vpc.my-vpc.id
}

output "dev-subnet-id" {
  value = aws_subnet.my-subnet.id
}