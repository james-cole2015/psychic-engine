output "vpc" {
  value = module.vpc
}

output "jenkins-sg" {
  value = aws_security_group.jenkins-sg
}

output "vpc_zone_identifier" {
  value = module.vpc.vpc_id
}

/*
output "bastion-host-sg" {
  value = aws_security_group.bastion-host-sg
}
*/