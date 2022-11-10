resource "tls_private_key" "rsa" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

module "key_pair" {
  source  = "terraform-aws-modules/key-pair/aws"
  version = "2.0.0"

  key_name   = "${var.repo-name}-tf_key"
  public_key = tls_private_key.rsa.public_key_openssh
}

resource "local_file" "created_keypair_to_local" {
  content         = tls_private_key.rsa.private_key_openssh
  file_permission = "400"
  filename        = "${module.key_pair.key_pair_name}.pem"
}


resource "aws_secretsmanager_secret" "private-key" {
    name = "${var.repo-name}-${var.random_number}-private-key"
}

resource "aws_secretsmanager_secret" "public-key" {
    name = "${var.repo-name}-${var.random_number}-public-key"
}


resource "aws_secretsmanager_secret_version" "keypair" {
    secret_id = aws_secretsmanager_secret.private-key.id
    secret_string = "${tls_private_key.rsa.private_key_openssh}"
}

resource "aws_secretsmanager_secret_version" "pub_keypair" {
  secret_id = aws_secretsmanager_secret.public-key.id
  secret_string = "${tls_private_key.rsa.public_key_openssh}"
}
