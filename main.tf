# -----------------------------------------------------------------------------
# Main Terraform Configuration for test_s3_project (Lambda Only)
# -----------------------------------------------------------------------------

# Generate unique suffix for resource naming
resource "random_string" "suffix" {
  length  = 6
  special = false
  upper   = false
}

locals {
  common_tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
    Owner       = "Kishor"
  }
}
