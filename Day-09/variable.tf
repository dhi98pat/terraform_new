#=====================
# General Variables
#=====================
variable "region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}


variable "environment" {
  description = "Environment name (e.g., dev, staging, prod)"
  type        = string
  default     = "dev"
}

## =====================
# S3 Bucket Variables
## =====================

variable "bucket_names" {
  description = "Set of s3 bucket names to create"
  type        = set(string)
  default     = ["demo-lifecycle-bucket-001", "demo-lifecycle-bucket-002", "demo-lifecycle-bucket-003"]

}

variable "allowed_regions" {
  description = "List of allowed AWS regions"
  type        = list(string)
  default     = ["us-east-1", "us-west-1", "eu-west-1"]
}
### ======================
## EC2 variables
### ======================

variable "instance_type" {
  description = "Ec2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "instance_name" {
  description = "Name tag for EC2 instance"
  type        = string
  default     = "Lifecycle-Demo-Instance"
}

##======================
# RDS Variables
##======================

variable "db_username" {
  description = "Database adminstrator username"
  type        = string
  default     = "admin"
  sensitive   = true
}

variable "db_password" {
  description = "Database administrator password"
  type        = string
  default     = "P@ssw0rd1234"
  sensitive   = true
}
variable "db_name" {
  description = "Initial database name"
  type        = string
  default     = "myappdb"
}

##======================
# Tags variable
##======================

variable "resource_tags" {
  description = "Common tags to apply to resources"
  type        = map(string)
  default = {
    "Environment" = "dev"
    Team          = "DevOps"
    CostCenter    = "Engineering"
  }
}