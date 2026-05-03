## Creating S3 bucket with tags and outputting the bucket name
# main.tf

# Generate random suffix for globally unique bucket name
resource "random_string" "bucket_suffix" {
  length  = 8
  special = false
  upper   = false
  lower   = true
}

# Refrence with var. prefix and random suffix for uniqueness
resource "aws_s3_bucket" "test" {
    bucket = "${var.bucket_name}-${random_string.bucket_suffix.result}"
    tags = {
        Environment = var.environment
    }
}