# Workspaces
locals {
    vpc_ids = {
        dev = "vpc-12345"
        prod = "vpc-67890"
    }
}

resource "aws_subnet" "private" {
  vpc_id = lookup(local.vpc_ids, terraform.workspace, "dev" )
}

# Data
data "aws_vpc" "main" {
    tags = {
        Name = "mainVPC"
    }
}

resource "aws_subnet" "private" {
  vpc_id = data.aws_vpc.main.id
}

# State Data
data "terraform_remote_state" "vpc" {
    backend = "s3"

    config = {
        bucket = "my-tf-state-bucket"
        key    = "path/to/my/key"
        region = "us-east-1"
    }
}

resource "aws_subnet" "private" {
  vpc_id = data.terraform_remote_state.vpc.outputs.id
}
