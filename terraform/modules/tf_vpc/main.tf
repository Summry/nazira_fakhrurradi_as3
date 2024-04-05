provider "aws" {
  region = var.region
}

resource "aws_vpc" "vpc_1" {
  cidr_block = var.cidr_block
  instance_tenancy = "default"
  enable_dns_hostnames = true
  tags = {
    Name = "vpc_1"
    Project = var.project_name
  }
}