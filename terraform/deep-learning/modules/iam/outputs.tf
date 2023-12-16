output "dlami_admin_role_arn" {
  description = "DLAMI admin role ARN"
  value = aws_iam_role.dlami_admin.arn
}

output "dlami_admin_role_name" {
  description = "DLAMI admin role name"
  value = aws_iam_role.dlami_admin.name
}

output "dlami_admin_ec2_instance_profile_name" {
  description = "DLAMI admin instance profile"
  value = aws_iam_instance_profile.dlami_admin.name
}
