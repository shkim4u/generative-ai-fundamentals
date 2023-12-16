module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "5.1.0"

  /*
   * Basic information
   */
  name = "Deep-Learning-VPC"
  cidr = "10.1.0.0/16"
  azs = var.azs

  /*
   * Subnets
   */
  public_subnets = var.public_subnets
  private_subnets = var.private_subnets
  private_subnet_tags = {
    "Purpose": "Private Subnet for Deep Learning"
  }
  public_subnet_tags = {
    "Purpose": "Public Subnet for Deep Learning"
  }

  /*
   * Misc.
   */
  enable_nat_gateway = true
  single_nat_gateway = false
  enable_dns_support = true
  enable_dns_hostnames = true

  map_public_ip_on_launch = true
}
