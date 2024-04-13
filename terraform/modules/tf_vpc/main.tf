/*
  This module creates a VPC with a public subnet, an internet gateway, a route table and a route table association.
*/

provider "aws" {
  region = var.region
}

resource "aws_vpc" "vpc_1" {
  /* 
    This is the VPC that will be created.
  */

  cidr_block           = var.vpc_cidr
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  tags = {
    Name    = "vpc_1"
    Project = var.project_name
  }
}

resource "aws_subnet" "sn_1" {
  /* 
    This is the public subnet that will be created.
  */

  vpc_id                  = aws_vpc.vpc_1.id
  cidr_block              = var.sn_1_cidr
  availability_zone       = var.availability_zone
  map_public_ip_on_launch = true
  tags = {
    Name    = "sn_1"
    Project = var.project_name
  }
}

resource "aws_internet_gateway" "gw_1" {
  /* 
    This is the internet gateway that will be created.
  */

  vpc_id = aws_vpc.vpc_1.id
  tags = {
    Name    = "gw_1"
    Project = var.project_name
  }
}

resource "aws_route_table" "rt_1" {
  /* 
    This is the route table that will be created.
  */

  vpc_id = aws_vpc.vpc_1.id
  route {
    cidr_block = var.default_route
    gateway_id = aws_internet_gateway.gw_1.id
  }

  tags = {
    Name    = "rt_1"
    Project = var.project_name
  }
}

resource "aws_route_table_association" "rt_assoc_1" {
  /* 
    This is the route table association that will be created.
  */

  subnet_id      = aws_subnet.sn_1.id
  route_table_id = aws_route_table.rt_1.id
}
