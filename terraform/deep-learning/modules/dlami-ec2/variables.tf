variable "vpc_id" {}
variable "subnet_id" {}
variable "role_name" {}
variable "instance_profile_name" {}
variable "instance_profile_arn" {}
variable "instance_type" {
	default = "g5.16xlarge"
}