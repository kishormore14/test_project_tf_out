# -----------------------------------------------------------------------------
# Terraform State Backend Configuration
# Defaulting to local state for CI/CD ephemeral runs.
# To enable remote S3 backend, uncomment the block below with a valid bucket.
# -----------------------------------------------------------------------------

# terraform {
#   backend "s3" {
#     bucket       = "my-app-storage-q6gk1p"
#     key          = "terraform-state/test-project-tf-out/terraform.tfstate"
#     region       = "ap-south-1"
#     encrypt      = true
#     use_lockfile = true
#   }
# }
