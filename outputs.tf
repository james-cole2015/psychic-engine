output "random_id_num" {
  value = module.aws_data.random_number.result
}

output "iam-user-name" {
  value = module.aws_data.iam-user.user_name
}

output "iam-user-arn" {
  value = module.aws_data.iam-user.arn
}

output "random_pet" {
  value = module.aws_data.petname.id
}

output "ami-id" {
  value = module.aws_data.ami.id
}

output "availability-zones" {
value = data.aws_availability_zones.zones.names 
}
