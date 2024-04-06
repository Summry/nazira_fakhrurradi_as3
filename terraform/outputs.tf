output "vpc_id" {
  value = module.vpc.vpc_id
}

output "sn_1" {
  value = module.vpc.sn_1_id
}

output "gw_1" {
  value = module.vpc.gw_1_id
}

output "rt_1" {
  value = module.vpc.rt_1_id
} 

output "sg_1" {
  value = module.sg.sg_1_id
}

output "almost_private_sg" {
  value = module.sg.almost_private_sg_id
}

output "public_instance_id" {
  value = module.ec2.public_instance_id
}

output "almost_private_instance_id" {
  value = module.ec2.almost_private_instance_id
}

output "public_instance_dns" {
  value = module.ec2.public_instance_public_dns
}

output "almost_private_instance_dns" {
  value = module.ec2.almost_private_instance_public_dns
}
