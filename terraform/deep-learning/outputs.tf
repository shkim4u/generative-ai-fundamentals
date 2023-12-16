/*
 * Outputs from network resources.
 */
output "network_vpc_id" {
  description = "(Network) VPC ID"
  value = module.network.vpc_id
}

output "network_vpc_cidr_block" {
  description = "(Network) VPC CIDR block"
  value = module.network.vpc_cidr_block
}

output "network_private_subnets_cidr_blocks" {
  description = "(Network) Private subnets CIDR block"
  value = module.network.private_subnets_cidr_blocks
}

output "network_public_subnets_cidr_blocks" {
  description = "(Network) Public subnets CIDR block"
  value = module.network.public_subnets_cidr_blocks
}

/*
 * Outputs from IAM resources.
 */
output "iam_dlami_admin_role_arn" {
  description = "(IAM) DLAMI admin role ARN"
  value = module.iam.dlami_admin_role_arn
}

output "iam_dlami_admin_ec2_instance_profile" {
  description = "(IAM) DLAMI admin EC2 instance profile"
  value = module.iam.dlami_admin_ec2_instance_profile_name
}

/*
 * Outputs from DLAMI EC2 instance resources.
 */

output "dlami_ec2_instance_public_ip" {
  description = "(DLAMI EC2) Public IP of DLAMI instance"
  value = var.exclude_dlami_instance ? null : module.dlami_ec2[0].public_ip
}