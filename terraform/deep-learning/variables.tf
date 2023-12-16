variable "region" {
  description = "AWS Region"
  type = string
  default = "ap-northeast-2"
}

variable "exclude_dlami_instance" {
  description = "True or False to exclude Amazon DLAMI instance for deep learning"
  default = false
}
