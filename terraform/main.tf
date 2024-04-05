module "vpc" {
  source = "./modules/tf_vpc"
  project_name = var.project_name
  region = var.region
}