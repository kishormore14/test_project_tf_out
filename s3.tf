# -----------------------------------------------------------------------------
# AWS S3 Object Storage Resources
# -----------------------------------------------------------------------------

# Generate unique suffix for S3 bucket name
resource "random_string" "suffix" {
  length  = 6
  special = false
  upper   = false
}

locals {
  bucket_name = "${var.project_name}-${random_string.suffix.result}"

  common_tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
    Owner       = "Kishor"
  }
}

# 1. AWS S3 Bucket
resource "aws_s3_bucket" "app_storage" {
  bucket        = local.bucket_name
  force_destroy = true

  tags = merge(local.common_tags, {
    Name    = local.bucket_name
    Service = "S3"
  })
}

# 2. S3 Bucket Versioning
resource "aws_s3_bucket_versioning" "storage_versioning" {
  bucket = aws_s3_bucket.app_storage.id

  versioning_configuration {
    status = "Enabled"
  }
}

# 3. Server-Side Encryption (AES256)
resource "aws_s3_bucket_server_side_encryption_configuration" "storage_encryption" {
  bucket = aws_s3_bucket.app_storage.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}
