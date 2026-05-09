variable "project_name" {
  default = "Project ALPHA Resource Group"
}


variable "default_tags" {
    default = {
        company = "Hello World Inc."
        managed_by = "Terraform"
    }
}

variable "environment_tags" {
    default = {
        environment = "production"
        cost_center = "cc-12345"
    }
}

variable "bucket_name" {
    default = "ProjectAlphaResourceGroup with CAPS and spaces!!!"
  
}

variable "allowed_ports" {
    default = "80, 443, 8080, 22"
  
}

variable "instance_sizes" {
    default = {
        dev = "t2.micro"
        staging = "t2.small"
        production = "t2.medium"
    }
  
}

variable "environment" {
    default = "production"
  
}

variable "instance_type" {
    default = "t2.micro"
   
    validation {
      condition = length(var.instance_type) >= 2 && length(var.instance_type) <= 20
      error_message = "Instance type must be between 2 and 20 characters."
    }
    validation {
      condition = can(regex("^t[2-3]\\.",var.instance_type))
      error_message = "Instance type must start with 't2.' or 't3.'."
    }
}

variable "backup_name" {
    default = "daily-backup"
    validation {
        condition = endswith(var.backup_name, "_backup")
        error_message = "Backup name should must end with '_backup'"
    }  
}

variable "credentials" {
    default = "12345465"
    sensitive = true
  
}

variable "user_location" {
    default = ["us-east-1", "us-west-2", "us-east-1"] # Has duplicate value to test the distinct function in main.tf
}

variable "default_locations" {
    default = ["us-west-1"]
}

variable "monthly_costs" {
    default = [-50, 1000, 1500, 200] # -ve is a credit and +ve is a debit
}