variable "region" {
  description = "AWS Region"
  type = string
  default = "ap-northeast-2"
}

variable "exclude_dlami_instance" {
  description = "True or False to exclude Amazon DLAMI instance for deep learning"
  default = false
}

variable "dlami_instance_type" {
  description = "Amazon DLAMI instance type for deep learning"
  default = "g5.16xlarge"
}