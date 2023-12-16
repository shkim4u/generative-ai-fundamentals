module "network" {
  source = "./modules/network"
}

module "iam" {
  source = "./modules/iam"
}

module "dlami_ec2" {
  source = "./modules/dlami-ec2"
  subnet_id = module.network.public_subnets[0]
  role_name = module.iam.dlami_admin_role_name
  vpc_id = module.network.vpc_id
  instance_profile_name = module.iam.dlami_admin_ec2_instance_profile_name
}
