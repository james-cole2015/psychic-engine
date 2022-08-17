resource "random_integer" "rando-id" {
  min = 10000
  max = 999999
}

data "aws_iam_user" "s3_user" {
  user_name = var.user-name
}

resource "random_pet" "test" {
  length = 2
}

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
}