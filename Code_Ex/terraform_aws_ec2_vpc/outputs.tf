output "vpc_id" {
  value = aws_vpc.test_vpc.id
}
output "ec2_instance" {
  value = aws_instance.tesing_ec2.id
}
output "private_subnet" {
  value = aws_subnet.private_subnet.id
}

output "public_subnet" {
  value = aws_subnet.public_subnet.id
}

output "route_table" {
  value = aws_route_table.private_rt.id
}

output "eip" {
  value = aws_eip.nat_eip.id
}