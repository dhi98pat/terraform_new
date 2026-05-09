resource "aws_instance" "web" {
  count         = var.webserver_count
  ami           = var.ami_id
  instance_type = var.instance_type
  tags          = var.tags
}