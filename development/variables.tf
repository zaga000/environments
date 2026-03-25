variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "eu-central-1"

  validation {
    condition     = contains(["eu-west-1", "eu-west-2", "eu-west-3", "eu-central-1", "eu-north-1"], var.aws_region)
    error_message = "AWS region must be in Europe zone"
  }
}

variable "vpc_cidr_block" {
  description = <<-EOF
    The IPv4 address range for the VPC in CIDR notation.
    Example: 10.0.0.0/16 or 172.16.0.0/12.
    The block size must be between /16 and /28 netmasks.
  EOF
  type        = string
  default     = "10.0.0.0/16"

  validation {
    condition     = can(regex("^([0-9]{1,3}\\.){3}[0-9]{1,3}/[0-9]+$", var.vpc_cidr_block))
    error_message = "The vpc_cidr value must be a valid IPv4 CIDR notation"
  }

}

variable "environment" {
  description = "Envirionment name (ex. dev, stage, prod)"
  type        = string

  validation {
    condition     = contains(["prod", "dev", "stage"], var.environment)
    error_message = <<-EOF
      Name of environment doesn't match. The correct one is:
       - dev
       - stage
       - prod
    EOF
  }
}

variable "name" {
  description = "Project name"
  type        = string

  validation {
    condition     = length(var.name) > 3
    error_message = "Name of project must be longer then 3 letters"
  }
}

variable "public_subnet_count" {
  description = "Number of public subnets to create"
  type        = number
  default     = 2
}

variable "private_subnet_count" {
  description = "Number of public subnets to create"
  type        = number
  default     = 2
}

variable "db_subnet_count" {
  description = "Number of public subnets to create"
  type        = number
  default     = 2
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Additional tags"
}