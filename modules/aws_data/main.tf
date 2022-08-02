resource "random_integer" "rando-id" {
    min = 10000
    max = 999999
}

data "aws_iam_user" "s3_user" {
    user_name = "${var.user-name}"
}

resource "random_pet" "test" {
    length = 2
}