/* This file is used to create security groups in AWS */

provider "aws" {
  region = var.region
}

resource "aws_security_group" "sg_1" {
  name = "sg_1"
  description = "Allow HTTP and SSH access to ec2"
  vpc_id = var.vpc_id
}

resource "aws_security_group" "almost_private_sg_1" {
  name = "almost_private_sg_1"
  description = "Allow SSH access to ec2"
  vpc_id = var.vpc_id
}

resource "aws_vpc_security_group_egress_rule" "egress_rule" {
  security_group_id = aws_security_group.sg_1.id
  ip_protocol = -1
  cidr_ipv4 = var.sg_cidr
  tags = {
    Name = "egress_rule"
    Project = var.project_name
  }
}

resource "aws_vpc_security_group_ingress_rule" "ingress_rule_http" {
  security_group_id = aws_security_group.sg_1.id
  from_port = 80
  to_port = 80
  ip_protocol = "tcp"
  cidr_ipv4 = var.sg_cidr
  tags = {
    Name = "ingress_rule_http"
    Project = var.project_name
  }
}

resource "aws_vpc_security_group_ingress_rule" "ingress_rule_ssh" {
  security_group_id = aws_security_group.sg_1.id
  from_port = 22
  to_port = 22
  ip_protocol = "tcp"
  cidr_ipv4 = var.sg_cidr
  tags = {
    Name = "ingress_rule_ssh"
    Project = var.project_name
  }
}

resource "aws_vpc_security_group_egress_rule" "almost_private_egress_rule" {
  security_group_id = aws_security_group.almost_private_sg_1.id
  ip_protocol = -1
  cidr_ipv4 = var.sg_cidr
  tags = {
    Name = "almost_private_egress_rule"
    Project = var.project_name
  }
}

resource "aws_vpc_security_group_ingress_rule" "almost_private_ingress_rule_ssh" {
  security_group_id = aws_security_group.almost_private_sg_1.id
  from_port = 22
  to_port = 22
  ip_protocol = "tcp"
  cidr_ipv4 = var.sg_cidr
  tags = {
    Name = "almost_private_ingress_rule_ssh"
    Project = var.project_name
  }
}

resource "aws_vpc_security_group_ingress_rule" "almost_private_ingress_rule_http" {
  security_group_id = aws_security_group.almost_private_sg_1.id
  from_port = 80
  to_port = 80
  ip_protocol = "tcp"
  cidr_ipv4 = var.vpc_cidr

  tags = {
    Name = "almost_private_ingress_rule_http"
    Project = var.project_name
  }
}
