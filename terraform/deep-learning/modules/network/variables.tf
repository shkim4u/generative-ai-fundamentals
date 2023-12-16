variable "azs" {
  description = "A list of availability zones names or ids in the region"
  type = list(string)
  default = ["ap-northeast-2a", "ap-northeast-2c"]
}

variable "public_subnets" {
  description = "Public subnets of VPC"
  type = list(string)
  default = ["10.1.0.0/24", "10.1.1.0/24"]
}

variable "private_subnets" {
  description = "Private subnets of VPC"
  type = list(string)
  default = ["10.1.10.0/24", "10.1.11.0/24"]
}
