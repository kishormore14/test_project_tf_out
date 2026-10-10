# -----------------------------------------------------------------------------
# AWS DynamoDB Table Resources (PAY_PER_REQUEST On-Demand)
# -----------------------------------------------------------------------------

# 1. AWS DynamoDB Table
resource "aws_dynamodb_table" "app_table" {
  name         = "${var.project_name}-table-${random_string.suffix.result}"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "UserId"
  range_key    = "CreatedAt"

  attribute {
    name = "UserId"
    type = "S"
  }

  attribute {
    name = "CreatedAt"
    type = "S"
  }

  ttl {
    attribute_name = "TimeToLive"
    enabled        = true
  }

  tags = {
    Environment = var.environment
  }
}
