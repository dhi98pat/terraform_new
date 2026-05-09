output "instance_ids" {
    value = aws_instance.web.*.id
    description = "IDs of the created EC2 instances"  
}