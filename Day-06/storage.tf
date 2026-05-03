# Random suffix for globally unique bucket name
resource "random_id" "bucket_suffix" {
  byte_length = 4

  keepers = {
    project     = var.project_name
    environment = var.environment
  }
}

## S3

resource "aws_s3_bucket" "main" {
  bucket = local.bucket_name
  tags = merge(local.common_tags, {
    Name        = local.bucket_name
    Purpose     = "General storage"
    Environment = var.environment
  })
}

## S3 Bucket with versioning enabled
resource "aws_s3_bucket_versioning" "main" {
  bucket = aws_s3_bucket.main.id

  versioning_configuration {
    status = "Enabled"
  }
}

## S3 Bucket with server-side encryption enabled
resource "aws_s3_bucket_server_side_encryption_configuration" "main" {
  bucket = aws_s3_bucket.main.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
    bucket_key_enabled = true
  }
}

## S3  Bucket with public access block
resource "aws_s3_bucket_public_access_block" "main" {
  bucket = aws_s3_bucket.main.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}