# Load VPC configuration from JSON file
locals { vpcs_config = jsondecode(file("${path.module}/vpc.json")) }

# Generate a random suffix for the S3 bucket name to ensure uniqueness
resource "random_id" "bucket_suffix" {
  byte_length = 4
}

# Legacy single VPC module (commented out - replaced by multi_vpc module below)
#module "vpc" {
#  source = "git::https://github.com/zaga000/terraform-aws-vpc.git?ref=v0.0.1"
#
#  environment          = var.environment
#  name                 = var.name
#  vpc_cidr_block       = var.vpc_cidr_block
#  public_subnet_count  = var.public_subnet_count
#  private_subnet_count = var.private_subnet_count
#  db_subnet_count      = var.db_subnet_count
#
#  tags = merge(
#    local.common_tags,
#    {
#      name = "${local.project_name}-vpc"
#    }
#  )
#
#}

# S3 bucket module 
module "s3" {
  source        = "terraform-aws-modules/s3-bucket/aws"
  version       = "4.1.2"
  bucket        = lower("${var.environment}-${var.name}-bucket-${random_id.bucket_suffix.hex}")
  force_destroy = true

  tags = merge(
    local.common_tags,
    {
      name = "${local.project_name}-s3-bucket"
    }
  )

}
# Multi-VPC module that creates multiple VPCs based on configuration in vpc.json
module "multi_vpc" {
  source = "git::https://github.com/zaga000/terraform-aws-vpc.git?ref=v0.0.2"

  for_each             = { for vpc in local.vpcs_config.vpcs : vpc.vpc_name => vpc.vpc_attributes }
  name                 = each.key
  environment          = var.environment
  vpc_cidr_block       = each.value.cidr_block
  public_subnet_count  = lookup(each.value, "public_subnet_count", lookup(each.value, "public_subnets_count", var.public_subnet_count))
  private_subnet_count = lookup(each.value, "private_subnet_count", lookup(each.value, "private_subnets_count", var.private_subnet_count))
  db_subnet_count      = lookup(each.value, "db_subnet_count", lookup(each.value, "db_subnets_count", var.db_subnet_count))

  tags = merge(
    local.common_tags,
    {
      name = "${local.project_name}-vpc"
    }
  )
}

<<<<<<< HEAD
# Commented out VPC resource (separate from the multi_vpc module above)
resource "aws_vpc" "vpc" {
  cidr_block = "10.2.0.0/24"

  tags = {
    name = "my-vpc-01"
  }
  lifecycle {
    ignore_changes = [tags]
  }
}

# Commented out data source for VPC (used for importing existing VPC)
#data "aws_vpc" "vpc" {
#  filter {
#    name = "tag:name"
#    values = ["my-vpc-01"]
#  }
#}

# Commented out removed block (used for refactoring/migration)
#removed {
#  from = aws_vpc.vpc
#  lifecycle {
#    destroy = false
#  }
#}

# Commented out import block (used for importing existing AWS resources)
#import {
#  to = aws_vpc.vpc
#  id = data.aws_vpc.vpc.id
#}
=======
module "vpc2" {
  source = "git::https://github.com/zaga000/terraform-aws-vpc.git?ref=v0.0.2"

  name                 = "test2"
   environment          = var.environment
  vpc_cidr_block       = "10.20.0.0/16"
}
>>>>>>> bf11aba (Test)
