variable "environment" {
  description = "Environment name (e.g., dev, staging, prod)"
  type        = string
  default     = "staging"

  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Environment must be one of: dev, staging, prod."
  }
}

variable "region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "instance_count" {
  description = "Number of EC2 instances to create"
  type        = number

#   validation {
#     condition     = var.instance_count > 0
#     error_message = "Instance count must be greater than zero."
#   }  
}

variable "monitoring" {
  description = "Enable detailed monitoring for EC2 instances"
  type        = bool
  default     = true
}

variable "associate_public_ip" {
  description = "Whether to associate a public IP address with the EC2 instances"
  type        = bool
  default     = true
}

variable "cidr_block" {
  description = "CIDR block for the VPC"
  type        = list(string)
  default     = ["10.0.0.0/16", "192.168.0.0/16", "172.16.0.0/12"]
}

variable "allowed_vm_types" {
  description = "List of allowed EC2 instance types"
  type        = list(string)
  default     = ["t2.micro", "t3.micro", "t3a.micro"]
}

variable "allowed_regions" {
  description = "List of allowed AWS regions"
  type        = set(string)
  default     = ["us-east-1", "us-west-2", "eu-west-1"]
}

variable "tags" {
  description = "A map of tags to assign to resources"
  type        = map(string)
  default     = {
    Environment = "dev"
    Name       = "dev-EC2-instance"
    CreatedBy  = "Terraform"
  }
}

variable "ingress_values" {
    type = tuple([string, number, number])
    default = ["tcp", 443, 443]
}

variable "config" {
    type = object({
        region = string
        monitoring = bool
        instance_count = number
    })
    default = {
        region = "us-east-1"
        monitoring = true
        instance_count = 1
    }
}