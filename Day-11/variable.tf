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
