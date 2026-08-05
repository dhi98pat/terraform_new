variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}
variable "vpc_cidr" {
  description = "CIDR range for the VPC"
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  default = "10.0.1.0/24"
}
variable "private_subnet_cidr" {
  default = "10.0.2.0/24"
}
variable "instance_type" {
  default = "t2.micro"
}
variable "ami_id" {
  default = "ami-0236922087fa98b6e"
}

variable "ssh_key_name" {
  description = "SSH key pair name"
  type        = string
  default = "shell"
}

variable "tags" {
  description = "Name to tag the application"
  default     = "testing_ec2"
}