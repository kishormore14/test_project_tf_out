# -----------------------------------------------------------------------------
# AWS Systems Manager Parameter Store Resources
# -----------------------------------------------------------------------------

# 1. AWS SSM Config Parameter
resource "aws_ssm_parameter" "config_endpoint" {
  name        = "/${var.project_name}/config/api_endpoint"
  description = "Application configuration endpoint parameter"
  type        = "String"
  value       = "https://api.${var.project_name}.internal/v1"
  tier        = "Standard"

  tags = merge(local.common_tags, {
    Name    = "/${var.project_name}/config/api_endpoint"
    Service = "SSM"
  })
}

# 2. AWS SSM DB User Parameter
resource "aws_ssm_parameter" "db_username" {
  name        = "/${var.project_name}/config/db_user"
  description = "Database administrator username"
  type        = "String"
  value       = "admin_${random_string.suffix.result}"
  tier        = "Standard"

  tags = merge(local.common_tags, {
    Name    = "/${var.project_name}/config/db_user"
    Service = "SSM"
  })
}
