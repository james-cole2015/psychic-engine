variable "repo-name" {
  type = any
}
variable "instance-type" {
  type    = string
  default = "t2.small"
}
/*
variable "vpc" {
  type = any
}
*/
variable "subnet_id" {
  type    = any
  default = ["$(module.networking.vpc.public_subnets[0]"]
}

variable "security_group" {
  type = any
}
variable "key_name" {
  type = any
}