# Configure the AWS Provider
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.100"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = var.primary
  alias = "primary"
}

provider "aws" {
  region = var.secondry
  alias = "secondary"
}

provider "aws" {
  region = var.secondry
  alias = "secondry"
}
