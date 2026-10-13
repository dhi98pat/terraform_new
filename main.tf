# main.tf
provider "aws" {
  region = "us-east-1"
}

module "ec2_instance" {
  source = "./module/ec2"

  instance_name = "example-instance"
  instance_type = "t3.micro"
  ami_id        = "ami-0bdc7d025135d7b49" # Amazon Linux 2 AMI (update per region)
}
