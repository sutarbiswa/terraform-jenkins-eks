variable "vpc_cidr" {
  description = "CIDR for the VPC"
  type        = string

}

variable "public_subnets" {
  description = "CIDR for the public subnets"
  type        = list(string)

}

variable "private_subnets" {
  description = "CIDR for the private subnets"
  type        = list(string)

}