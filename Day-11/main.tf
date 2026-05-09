locals {
  formatted_project_name = lower(replace(var.project_name, " ", "-"))
  new_tags = merge(var.default_tags, var.environment_tags)
  formated_bucket_name = replace(replace(substr((lower(var.bucket_name)), 0, 63), " ", "-"), "!", "")
  allowed_port_list = split(", ", var.allowed_ports)
  sg_rules = [ for port in local.allowed_port_list : {
    name = "port-${port}"
    post = port
    description = "Allow traffic on port ${port}"
  }]
  instance_size = lookup(var.instance_sizes, var.environment, "t2.micro")
}

resource "aws_s3_bucket" "first_bucket" {
  bucket = local.formated_bucket_name
  #tags = merge(var.default_tags, var.environment_tags)
  tags = local.new_tags
}
