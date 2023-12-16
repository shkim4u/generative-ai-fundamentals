output "dlami_ec2_instance_public_ip" {
  description = "Public IP of DLAMI instance"
  value = module.ec2_instance.public_ip
}

output "dlami_ec2_instance_private_ip" {
  description = "Private IP of DLAMI instance"
  value = module.ec2_instance.private_ip
}
