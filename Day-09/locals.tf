##=========================
# Locals
##=========================

locals {
  common_tags = {
    Environment = var.environment
    Team        = "DevOps"
    ManagedBy   = "Terraform"
    Project     = "Lifecyle-Demo"
  }

  ## Timestamp for unique naming
  timestamp = formatdate("YYYY-MM-DD", timestamp())

  ## Environment-specific settings
  ec2_config = {
    dev = {
      instance_type = "t2.micro"
      multi_az      = false
    }
    staging = {
      instance_type = "t2.small"
      multi_az      = true
    }
    prod = {
      instance_type = "t2.medium"
      multi_az      = true
    }
  }

  ## Get configuration for current environment
  current_env_config = lookup(local.ec2_config, var.environment, local.ec2_config["dev"])

  ## Bucket naming convention
  bucket_prefix = "${var.environment}-lifecycle-demo"

  ## Formatted region name for bucket naming
  region_short = replace(data.aws_region.current.region, "-", "")

  ## Availability zones count
  az_count = length(data.aws_availability_zones.available.names)
}