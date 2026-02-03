## State file management using S3 backends.


# Backend configuration"
terraform {
  backend "s3" {
    bucket = "terrraform-state-file-1234567890"
    key    = "dev/terraform.tfstate"
    region = "us-east-1"
    encrypt = true
    use_lockfile  = true
  }
}

# Create a S3 bucket
resource "aws_s3_bucket" "tf_test_bucket" {
  bucket = "my-tf-test-bucket-1234567890-statefile"
  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}
# Versioning for the S3 bucket
resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.tf_test_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}
# Enable server-side encryption for the S3 bucket
resource "aws_s3_bucket_server_side_encryption_configuration" "sse" {
  bucket = aws_s3_bucket.tf_test_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}