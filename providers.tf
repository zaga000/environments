# Configure Terraform version and S3 backend for state management
terraform {
  required_version = ">= 1.14.0"

  backend "s3" {
    bucket         = "dev-terraform-state-mini-project-551"
    key            = "terraform.tfstate"
    region         = "eu-central-1"
    dynamodb_table = "terraform-state-lock"
    encrypt        = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

# Configure AWS provider with role assumption and default tags
provider "aws" {
  region = var.aws_region

  assume_role {
    role_arn     = "arn:aws:iam::131715058413:role/TerraformAdminRole"
    session_name = "TerraformDevAdminSession"
  }

  default_tags {
    tags = {
      Terraforn   = "true"
      Environment = "dev"
      Project     = "terraform-project"
    }
  }
}
