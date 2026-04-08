locals {
  mandatory_tags = {
    ManagedBy = "Terraform"
  }

  env_config = {
    dev1 = {
      environment = "dev1"
    }
    dev2 = {
      environment = "dev2"
    }
  }

  project_name = "${var.environment}-${var.name}-${terraform.workspace}"

  common_tags = merge(
    var.tags,
    local.mandatory_tags
  )

}