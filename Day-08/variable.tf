# Sting Types

variable "environment" {
  description = "Environment name (e.g., dev, staging, prod)"
  type        = string
  default     = "staging"
}

variable "region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

# Number Types
variable "instance_count" {
  description = "Number of EC2 instances to create"
  type        = number
  default     = 2
}

# Boolean Types

variable "enable_versioning" {
  description = "Enable versioning for S3 buckets"
  type        = bool
  default     = true
}

# List Types

variable "availability_zones" {
  description = "List of availability zones to deploy resources"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

# List Types - used with for_each meta-argument

variable "s3_bucket_names" {
  type = list(string)
  description = "List of S3 bucket names to create"
  default = ["tf-day10bucket-1234567890", "tf-day10bucket-bucket-0987654321", "tf-day10bucket-1122334455"]
}

# Set Types - used with for_each meta-argument

variable "s3_bucket_set" {
  type = set(string)
  description = "Set of S3 bucket names to create"
  default = ["tf-day10bucket-1234567890", "tf-day10bucket-bucket-0987654321", "tf-day10bucket-1122334455"]
}

# Map Types

variable "tags" {
  description = "A map of tags to assign to resources"
  type        = map(string)
  default     = {
    Environment = "dev"
    Name       = "dev-EC2-instance"
    CreatedBy  = "Terraform"
  }
}

## Object Types

variable "ec2_config"{
  description = "Configuration for EC2 instance"
  type = object({
    instance_type = string
    ami_id        = string
    key_name      = string
    volume_size   = number
  })
  default = {
    instance_type = "t2.micro"
    ami_id        = "ami-0c94855ba95c71c99" # Amazon Linux 2 AMI (HVM), SSD Volume Type
    key_name      = "my-key-pair"
    volume_size   = 20
  }

}

variable "network_config" {
  type = tuple([string, string, number])
  description = "Tuple for network configuration: [vpc_id, subnet_id, security_group_id]"
  default = ["10.0.0.0/16", "10.0.0.0/24", 3]
  
}