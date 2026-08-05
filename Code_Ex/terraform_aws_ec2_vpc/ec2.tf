resource "aws_instance" "tesing_ec2" {
  ami       = var.ami_id
  key_name  = var.ssh_key_name
  vpc_security_group_ids = [aws_security_group.web-server.id]
  instance_type = var.instance_type
  region    = var.aws_region
  subnet_id = aws_subnet.public_subnet.id

  tags = {
    Name = "testing-ec2"
  }
}