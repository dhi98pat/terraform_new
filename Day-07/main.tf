

resource "aws_instance" "example" {
  count = var.instance_count
  ami           = "ami-0eb38b817b93460ac"
  instance_type = var.allowed_vm_types[1]
  #region = tolist(var.allowed_regions)[0]
  region = var.config.region
  
  monitoring = var.monitoring
  associate_public_ip_address = var.associate_public_ip
  tags = var.tags
}

resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic and all outbound traffic"

  tags =var.tags
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = var.cidr_block[2]
  from_port         = var.ingress_values[1]
  ip_protocol       = var.ingress_values[0]
  to_port           = var.ingress_values[2]
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

