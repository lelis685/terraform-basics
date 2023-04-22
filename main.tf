terraform {
  required_version = "> 0.13"
  backend "s3" {
    bucket = "myapp-bucket-lelis685"
    key    = "myapp/state.tfstate"
    region = "us-east-1"
  }
}

resource "aws_vpc" "myapp-vpc" {
  cidr_block = var.vpc_cidr_block
  tags = {
    Name = "${var.env_prefix}-vpc"
  }
}

module "myapp-subnet" {
  source            = "./modules/subnet"
  subnet_cidr_block = var.subnet_cidr_block
  availability_zone = var.availability_zone
  env_prefix        = var.env_prefix
  vpc_id            = aws_vpc.myapp-vpc.id
}

module "myapp-server" {
  source            = "./modules/webserver"
  vpc_id            = aws_vpc.myapp-vpc.id
  my_ip             = var.my_ip
  env_prefix        = var.env_prefix
  availability_zone = var.availability_zone
  subnet_id         = module.myapp-subnet.subnet.id
  instance_type     = var.instance_type
}