module "vpc" {
  source = "./modules/tf_vpc"
  project_name = var.project_name
  region = var.region
  availability_zone = var.availability_zone
}

module "ec2" {
  source = "./modules/tf_ec2"
  sg_id = module.sg.sg_id
  subnet_id = module.vpc.sn_1_id
  region = var.region
  project_name = var.project_name
  ssh_key_name = var.ssh_key_name
  availability_zone = var.availability_zone
  almost_private_sg_id = module.sg.almost_private_sg_id
}

module "sg" {
  source = "./modules/tf_sg"
  vpc_id = module.vpc.vpc_id
  region = var.region
  project_name = var.project_name
}
  