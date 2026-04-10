locals {
  instance_type_by_workspace = {
    default = "t3.micro"
    dev     = "t3.micro"
    test    = "t3.small"
    prod    = "t3.medium"
  }

  instance_count_by_workspace = {
    default = 1
    dev     = 1
    test    = 2
    prod    = 3
  }

  instance_type  = lookup(local.instance_type_by_workspace, terraform.workspace, "t3.micro")
  instance_count = lookup(local.instance_count_by_workspace, terraform.workspace, 1)
}

resource "aws_instance" "app" {
  count         = local.instance_count
  ami           = "ami-0abcdef1234567890" # replace with valid AMI
  instance_type = local.instance_type

  tags = {
    Name        = "app-${terraform.workspace}-${count.index + 1}"
    Environment = terraform.workspace
  }
}