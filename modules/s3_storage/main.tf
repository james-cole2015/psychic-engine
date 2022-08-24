resource "aws_s3_bucket" "plex_storage" {
  bucket = "${var.repo-name}-${var.identifier}"
}

resource "aws_s3_bucket_acl" "plex_acl" {
  bucket = aws_s3_bucket.plex_storage.id
  acl    = "private"
}

/*
resource "aws_s3_bucket_versioning" "plex_versioning" {
  bucket = aws_s3_bucket.plex_storage.id
  versioning_configuration {
    status = "Enabled"
  }
}
*/
resource "aws_s3_bucket_server_side_encryption_configuration" "plex_ams_key" {
  bucket = aws_s3_bucket.plex_storage.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = var.plex_s3_key
      sse_algorithm     = "aws:kms"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "plex_block_pub" {
  bucket = aws_s3_bucket.plex_storage.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}