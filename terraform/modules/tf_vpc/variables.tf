variable "region" {
  description = "value of the region"
}

variable "vpc_cidr" {
  description = "value of the cidr block"
  default = "10.0.0.0/16"
}

variable "project_name" {
  description = "value of the project name"
}

variable "sn_1_cidr" {
  description = "value of the subnet cidr block"
  default = "10.0.1.0/24"
}

variable "availability_zone" {
  description = "value of the availability zone"
  default = "us-west-2a"
}

variable "default_route" {
  default = "0.0.0.0/0"
}