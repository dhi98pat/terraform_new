locals {
  common_tags = merge(var.tags, {
    Environment = var.environment
    Project     = var.project_name
    ManagedBy   = "Terraform"
    CreatedDate = formatdate("YYYY-MM-DD", timestamp())
  })
}

# naming convention
locals {
  name_prefix = "${var.project_name}-${var.environment}"

  # Network Configuration
  vpc_name = "${local.name_prefix}-vpc"

  # Storage Configuration - S3 bucket names must be lowercase and cannot contain underscores
  bucket_name = lower(replace("${local.name_prefix}-${random_id.bucket_suffix.hex}", "_", "-"))
}

