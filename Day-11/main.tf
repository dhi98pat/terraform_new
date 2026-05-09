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

  all_location = concat(var.user_location, var.default_locations)
  duplicate_location = toset(local.all_location)

  postive_cost = [ for cost in var.monthly_costs: abs (cost) ]
  max_cost = max(local.postive_cost...)
  min_cost = min(local.postive_cost...)
  total_cost = sum(local.postive_cost)
  average_cost = local.total_cost / length(local.postive_cost)

  current_time = timestamp()
}

resource "aws_s3_bucket" "first_bucket" {
  bucket = local.formated_bucket_name
  #tags = merge(var.default_tags, var.environment_tags)
  tags = local.new_tags
}
