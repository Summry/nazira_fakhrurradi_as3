variable "vpc_id" {
  description = "value of the vpc id"
}

variable "region" {
  description = "value of the region"
}

variable "sg_cidr" {
  description = "value of the cidr block"
  default = "0.0.0.0/0"
}

variable "project_name" {
  description = "value of the project name"
}