variable "webserver_count" {
  type        = number
  description = "Number of web servers to create"
  default = 3
}

variable "ami_id" {
  type        = string
  description = "AMI ID for the EC2 instances"
  default     = "ami-0c55b159cbfafe1f0"
}

variable "instance_type" {
  type        = string
  description = "EC2 instance type"
  default     = "t2.micro"
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
