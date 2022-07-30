output "vpc" {
  value = module.vpc
}

output "webserver-sg" {
  value = aws_security_group.webserver-sg
}

output "vpc_zone_identifier" {
  value = module.vpc.vpc_id
}

output "bastion-host-sg" {
  value = aws_security_group.bastion-host-sg
}