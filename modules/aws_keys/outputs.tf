output "key_name" {
  value = module.key_pair.key_pair_name
}
output "key_info" {
  value = module.key_pair
}

output "plex_s3_key" {
  value = aws_kms_key.plex_key
}