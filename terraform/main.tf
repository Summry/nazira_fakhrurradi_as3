module "vpc" {
  /*
    This module creates a VPC with a public subnet and a private subnet.
  */

  source = "./modules/tf_vpc"
  project_name = var.project_name
  region = var.region
  availability_zone = var.availability_zone
}

module "ec2" {
  /*
    * subnet_id: the ID of the subnet where the instances will be created
  */

  source = "./modules/tf_ec2"
  sg_id = module.sg.sg_1_id
  subnet_id = module.vpc.sn_1_id
  region = var.region
  project_name = var.project_name
  ssh_key_name = var.ssh_key_name
  availability_zone = var.availability_zone
  almost_private_sg_id = module.sg.almost_private_sg_id
}

module "sg" {
  /*
    This module creates the security groups for the instances.
  */
  
  source = "./modules/tf_sg"
  vpc_id = module.vpc.vpc_id
  region = var.region
  project_name = var.project_name
}
  