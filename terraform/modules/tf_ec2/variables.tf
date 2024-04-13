/* Variables */

variable "region" {
  description = "value of the region"
}

variable "project_name" {
  description = "value of the project name"
}

variable "name_tag" {
  description = "value of the name tag"
  default = "ec2_instance"
}

variable "availability_zone" {
  description = "value of the availability zone"
}

variable "ami_id" {
  description = "value of the ami"
  default = "ami-03b1462ad627ca95a"
}

variable "subnet_id" {
  description = "value of the subnet id"
}

variable "sg_id" {
  description = "value of the security group id"
}

variable "almost_private_sg_id" {
  description = "value of the almost private security group id"  
}

variable "instance_type" {
  description = "value of the instance type"
  default = "t2.micro"
}

variable "ssh_key_name" {
  description = "value of the ssh key name"
}

variable "ssh_public_key_path" {
  description = "value of the ssh public key path"
  default = "~/.ssh/4640_key.pub"
}

variable "ssh_private_key_path" {
  description = "value of the ssh private key path"
  default = "~/.ssh/4640_key"
}

variable "ansible_user" {
  description = "value of the ansible user"
  default = "ubuntu"
}
