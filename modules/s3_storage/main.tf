resource "aws_s3_bucket" "s3_backend" {
  bucket = "${var.repo-name}-${var.identifier}"
}

resource "aws_s3_bucket_acl" "plex_acl" {
  bucket = aws_s3_bucket.s3_backend.id
  acl    = "private"
}


resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.s3_backend.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "aws_kms_key" {
  bucket = aws_s3_bucket.s3_backend.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm      = "aws:kms"
      bucket_key_enabled = true
    }
  }
}

resource "aws_s3_bucket_public_access_block" "plex_block_pub" {
  bucket = aws_s3_bucket.s3_backend.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_policy" "plex-policy" {
  bucket = aws_s3_bucket.s3_backend.id
  policy = data.aws_iam_policy_document.plex_policy.json
}

data "aws_iam_policy_document" "plex_policy" {
  statement {
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::835867269469:user/AveryClark"]
    }
    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:ListBucket"
    ]
    resources = [
      "${aws_s3_bucket.s3_backend.arn}/*",
      aws_s3_bucket.s3_backend.arn
    ]
  }
}

