variable "repo-name" {
  type = any
}

variable "security_group" {
  type = any
}

variable "subnet_id" {
  type = any
  #default = ["$(module.networking.vpc.public_subnets[0]"]
}

variable "vpc" {
  type = string
}