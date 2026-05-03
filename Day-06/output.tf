## VPC ID Output
output "vpc_id" {
  description = "ID of the created VPC"
  value       = aws_vpc.main.id
}

output "vpc_cidr_block" {
  description = "CIDR block of the created VPC"
  value       = aws_vpc.main.cidr_block
}

output "vpc_arn" {
  description = "ARN of the created VPC"
  value       = aws_vpc.main.arn
}

output "public_subnet_ids" {
  description = "IDs of the created public subnets"
  value       = aws_subnet.public[*].id
}

output "public_subnet_cidrs" {
  description = "CIDR blocks of the created public subnets"
  value       = aws_subnet.public[*].cidr_block
}

output "s3_bucket_name" {
  description = "Name of the created S3 bucket"
  value       = aws_s3_bucket.main.bucket
}

output "s3_bucket_arn" {
  description = "ARN of the created S3 bucket"
  value       = aws_s3_bucket.main.arn
}

output "s3_bucket_versioning_status" {
  description = "Versioning status of the created S3 bucket"
  value       = aws_s3_bucket_versioning.main.versioning_configuration[0].status
}
output "s3_bucket_domain_name" {
  description = "Domain name of the created S3 bucket"
  value       = aws_s3_bucket.main.bucket_domain_name
}

output "environment" {
  description = "Environment name used for deployment"
  value       = var.environment
}

output "region" {
  description = "AWS region used for deployment"
  value       = var.region
}

output "common_tags" {
  description = "Common tags applied to all resources"
  value       = local.common_tags
}