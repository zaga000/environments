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
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"

  validation {
    condition     = can(regex("^([0-9]{1,3}\\.){3}[0-9]{1,3}/[0-9]+$", var.vpc_cidr_block))
    error_message = "The vpc_cidr value must be a valid IPv4 CIDR notation"
  }

}