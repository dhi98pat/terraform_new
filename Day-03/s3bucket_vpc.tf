# terraform {
#   required_providers {
#     aws = {
#       source = "hashicorp/aws"
#       version = "~> 6.0"
#     }
#   }
# }

# provider "aws" {
#   # Configuration options
#     region = "us-east-1"
# }
# Create a VPC
resource "aws_vpc" "tf_test_vpc" {
  cidr_block = "10.0.0.0/16"
    tags = {
        Name = "MyVPC"
    }
}
# Create a S3 bucket
resource "aws_s3_bucket" "tf_test_bucket_vpc" {
  bucket = "my-tf-test-bucket-1234567890-test-demo"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
    vpc_id      = aws_vpc.tf_test_vpc.id
  }
}