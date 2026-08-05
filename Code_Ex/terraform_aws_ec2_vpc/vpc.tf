resource "aws_vpc" "test_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags  = {
    Name = "testing_vpc"
  }
}