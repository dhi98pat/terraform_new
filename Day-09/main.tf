##========================
# Data Sources
##========================
# Get the latest Amazon Linux 2 AMI
data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

## Get available AWS availability zones
data "aws_availability_zones" "available" {
  state = "available"
}

## Get current AWS region
data "aws_region" "current" {}

## Random suffix for unique naming
resource "random_id" "suffix" {
  byte_length = 4
}

##===========================
# Example:01 create_before_destroy
# Use case: Ec2 instance that need zero downtime during updates
##===========================

resource "aws_instance" "web_server" {
  ami           = data.aws_ami.amazon_linux_2.id
  instance_type = var.instance_type

  tags = merge(
    var.resource_tags,
    {
      Name = var.instance_name
      Demo = "CreateBeforeDestroy"
    }
  )

  lifecycle {
    create_before_destroy = true
  }
}

###===========================
# Example:02 prevent_destroy
# Use case: Critical S3 bucket that should not be accidentally deleted
###===========================

resource "aws_s3_bucket" "critical_bucket" {
  bucket = "my-critical-bucket-${var.environment}-${random_id.suffix.hex}"
  tags = merge(
    var.resource_tags,
    {
      Name       = "CriticalBucket"
      Demo       = "PreventDestroy"
      DataType   = "Critical"
      Compliance = "Required"
    }
  )

  lifecycle {
    #prevent_destroy = true
  }
}

## Enable versioning for the critical bucket to protect against accidental deletions
resource "aws_s3_bucket_versioning" "critical_data" {
  bucket = aws_s3_bucket.critical_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

##===========================
# Example:03 ignore_changes
# Use case: Auto scaling group where capacity is managed externally
##===========================
## Launch template for auto scaling group
resource "aws_launch_template" "app_server" {
  name_prefix   = "app-server-"
  image_id      = data.aws_ami.amazon_linux_2.id
  instance_type = var.instance_type

  tag_specifications {
    resource_type = "instance"
    tags = merge(
      var.resource_tags,
      {
        Name = "AppServerInstance"
        Demo = "IgnoreChanges"
      }
    )
  }
}

# Auto scaling group 

resource "aws_autoscaling_group" "app_server" {
  name               = "app-server-asg"
  min_size           = 1
  max_size           = 5
  desired_capacity   = 2
  health_check_type  = "EC2"
  availability_zones = data.aws_availability_zones.available.names
  launch_template {
    id      = aws_launch_template.app_server.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "App Server ASG"
    propagate_at_launch = true
  }


  ## Lifecycle Rule: Ignore changes to desired_capacity since it's managed externally
  ## This is useful when auto-scaling policy or external system modify capacity
  ## Terraform won't try to revert capcacity changes made outside of Terraform
  lifecycle {
    ignore_changes = [
      desired_capacity
      ## Also ignor load balancers if added later by other processes.
    ]
  }
}

## ===========================
##Example:04 Precondition
## Use case: Ensure we're deploying to a specific region
##===========================

resource "aws_s3_bucket" "region_check_bucket" {
  bucket = "region-check-bucket-${var.environment}-${random_id.suffix.hex}"
  tags = merge(
    var.resource_tags,
    {
      Name = "RegionCheckBucket"
      Demo = "Precondition"
    }
  )

  lifecycle {
    precondition {
      condition     = contains(var.allowed_regions, data.aws_region.current.region)
      error_message = "This S3 bucket can only be created in one of the allowed regions."
    }
  }
}

##+===========================
## Example:05 Postcondition 
## Use case: Ensure S3 bucket has required tags after creation
##===========================

resource "aws_s3_bucket" "compliance_bucket" {
  bucket = "compliance-bucket-${var.environment}-${random_id.suffix.hex}"
  tags = merge(
    var.resource_tags,
    {
      Name       = "ComplianceBucket"
      Demo       = "Postcondition"
      Compliance = "SOC2"
    }
  )

  lifecycle {
    postcondition {
      condition     = contains(keys(self.tags), "Compliance")
      error_message = "This S3 bucket must have a 'Compliance' tag."
    }

    postcondition {
      condition     = contains(keys(self.tags), "Environment")
      error_message = "ERROR: This S3 bucket must have an 'Environment' tag."
    }
  }
}

## ===========================
## Example:06 Replacing triggered_by
## Use case: Replace EC2 instance when security groups change
##===========================
## Security group for the EC2 instance
resource "aws_security_group" "app_sg" {
  name        = "app-server-sg"
  description = "Security group for app server"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow HTTP traffic from anywhere"
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow HTTPS traffic from anywhere"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic"
  }
  tags = merge(
    var.resource_tags,
    {
      Name = "AppServerSG"
      Demo = "ReplacingTriggeredBy"
    }
  )
}

## EC2 instance that will be replaced if security group changes
resource "aws_instance" "app_server_with_sg" {
  ami             = data.aws_ami.amazon_linux_2.id
  instance_type   = var.instance_type
  security_groups = [aws_security_group.app_sg.name]

  tags = merge(
    var.resource_tags,
    {
      Name = "AppServerWithSG"
      Demo = "ReplacingTriggeredBy"
    }
  )

  lifecycle {
    replace_triggered_by = [
      aws_security_group.app_sg.id
    ]
  }
}

## ===========================
## Example:07 Multiple S3 buckets with create_before_destroy
## Use case: Migrate data between buckets without downtime
##===========================

resource "aws_s3_bucket" "app_bucket" {
  for_each = var.bucket_names
  bucket   = "${each.value}-${var.environment}-${random_id.suffix.hex}"
  tags = merge(
    var.resource_tags,
    {
      Name   = each.value
      Demo   = "MultipleBuckets"
      Bucket = each.key
    }
  )
  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

}

##===========================
## Example:08 Combining multiple lifecycle rules
## Use case: Critical S3 bucket with multiple protections
## This example shows how to combine multiple lifecycle rules for a single resource to provide layered protections.
## DynamoDB is used here becouse it's simple and donsen't require VPC setup
##===========================

resource "aws_dynamodb_table" "critical_table" {
  name         = "${var.environment}-critical-table"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "id"

  attribute {
    name = "id"
    type = "S"
  }

  tags = merge(
    var.resource_tags,
    {
      Name        = "CriticalTable"
      Demo        = "MultipleLifecycleRules"
      DataType    = "Critical"
      Environment = var.environment
    }
  )
  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
    precondition {
      condition     = contains(keys(var.resource_tags), "Environment")
      error_message = "Critical table must be tagged with an 'Environment' tag for compliance reasons."
    }
    postcondition {
      condition     = self.billing_mode == "PAY_PER_REQUEST" || self.billing_mode == "PROVISIONED"
      error_message = "This DynamoDB table can only be created with a valid billing mode."
    }
  }
}

