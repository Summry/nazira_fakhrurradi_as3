module "vpc" {
  source = "./modules/tf_vpc"
  project_name = var.project_name
  region = var.region
}

module "ec2" {
  source = "./modules/tf_ec2"
}

module "sg" {
  source = "./modules/tf_sg"
  vpc_id = module.vpc.vpc_id
  region = var.region
}
  