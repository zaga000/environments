resource "random_id" "bucket_suffix" {
  byte_length = 4
}

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
#    var.tags,
#    local.mandatory_tags,
#    {
#      name = "{var.environment}-${var.name}-vpc"
#    }
#  )
#
#}

module "s3" {
  source        = "terraform-aws-modules/s3-bucket/aws"
  version       = "4.1.2"
  bucket        = lower("${var.environment}-${var.name}-bucket-${random_id.bucket_suffix.hex}")
  force_destroy = true

  tags = merge(
    var.tags,
    local.mandatory_tags,
    {
      name = "${var.environment}-${var.name}-bucket"
    }
  )

}

module "multi_vpc" {
  source = "../../terraform-aws-vpc"

for_each = { for vpc in var.vpcs_config["vpcs"] : vpc.vpc_name => vpc.vpc_attributes }
  name                 = each.key
  environment          = var.environment
  vpc_cidr_block       = each.value.cidr_block
  public_subnet_count  = each.value.public_subnet_count
  private_subnet_count = each.value.private_subnet_count
  db_subnet_count      = each.value.db_subnet_count

  tags = merge(
    var.tags,
    local.mandatory_tags,
    {
      name = "${var.environment}-${var.name}-vpc"
    }
  )
}