## s3 backend bucket policy

/*
resource "aws_s3_bucket_policy" "backend-policy" {
    bucket = "${var.repo-name}-backend-${var.identifer}"
    policy = <<EOT
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "AWS": ["arn:aws:iam::835867269469:user/AveryClark","arn:aws:iam::959867141488:user/MatthewDavis"]
            },
            "Action": "s3:ListBucket",
            "Resource": "arn:aws:s3:::psychic-engine-backend-428127"
        },
        {
            "Effect": "Allow",
            "Principal": {
                "AWS": ["arn:aws:iam::835867269469:user/AveryClark","arn:aws:iam::959867141488:user/MatthewDavis"]
            },
            "Action": [
                "s3:GetObject",
                "s3:PutObject"
            ],
            "Resource": "arn:aws:s3:::psychic-engine-backend-428127/*"
        }
    ]
}
EOT
}*/