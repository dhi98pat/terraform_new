## Ex:1 Using count meta-argument to create multiple s3 buckets.
# resource "aws_s3_bucket" "my_bucket" {
  
#   count = length(var.s3_bucket_names)
#   bucket = var.s3_bucket_names[count.index]
#   tags = {
#     Name = var.s3_bucket_names[count.index]
#     Environment = var.environment
#     Index = count.index
#     ManagedBy = "Terraform"
#   }
# }

## Ex:2 Using for_each meta-argument to create multiple s3 buckets.
# resource "aws_s3_bucket" "my_bucket" {
#   for_each = var.s3_bucket_set
#   bucket = each.value
#   tags = {
#     Name = each.value
#     Environment = var.environment
#     ManagedBy = "Terraform"
#   }
# }

## Ex:3 Using Depends_on meta-argument to create dependency between resources.
# First create a bucket that will be used as a dependency
resource "aws_s3_bucket" "my_bucket" {
  bucket = "tf-day10bucket-1234567890-${var.environment}"
  tags = {
    Name = "my_bucket"
    Environment = var.environment
    ManagedBy = "Terraform"
  }
}

# Then create another bucket that depends on the first bucket
resource "aws_s3_bucket" "dependent_bucket" {
  bucket = "tf-day10bucket-0987654321-${var.environment}"
  tags = {
    Name = "dependent_bucket"
    Environment = var.environment
    ManagedBy = "Terraform"
  }
  depends_on = [aws_s3_bucket.my_bucket]
}

## Ex:4 Using lifecycle meta-argument to prevent resource deletion.
resource "aws_s3_bucket" "protected_bucket" {
  bucket = "tf-day10bucket-1122334455-${var.environment}"
  # lifecycle meta-argument to prevent resource deletion
  lifecycle {
    prevent_destroy = false
    create_before_destroy = true
    ignore_changes = [
      tags["CreatedDate"],
    ]
  }


  tags = {
    Name = "protected_bucket"
    Environment = var.environment
    ManagedBy = "Terraform"
    CreatedDate = timestamp()
  }
}