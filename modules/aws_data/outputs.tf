output "random_number" {
  value = random_integer.rando-id
}

output "petname" {
  value = random_pet.test
}

output "ami" {
  value = data.aws_ami.ubuntu
}

output "az_names" {
  value = data.aws_availability_zones.zones
}