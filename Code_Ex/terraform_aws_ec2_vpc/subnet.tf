resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.test_vpc.id
  cidr_block              = var.public_subnet_cidr
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "public_subnet"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.test_vpc.id
  cidr_block        = var.private_subnet_cidr
  availability_zone = "us-east-1b"
  tags = {
    Name = "private_subnet"
  }
}