output "formatted_project_name" {
  value = local.formatted_project_name
}

output "port_list" {
  value = local.allowed_port_list
}

output "sg_rule" {
    value = local.sg_rules
  
}

output "instance_size" {
    value = local.instance_size
  
}

output "credentiols" {
    value = var.credentials
    sensitive = true
  
}

output "all_location" {
    value = local.all_location
  
}

output "duplicate_location" {
    value = local.duplicate_location
  
}

output "postive_cost" {
    value = local.postive_cost
  
}

output "max_cost" {
    value = local.max_cost
}

output "min_cost" {
    value = local.min_cost
}

output "total_cost" {
    value = local.total_cost
}

output "average_cost" {
    value = local.average_cost
}

output "current_time" {
    value = local.current_time
}