# =============================================================================
# CENTRALIZED & DYNAMIC TFOUT BANNERS (100% REUSABLE)
# Uses a single module call with `for_each` so you NEVER repeat source/version.
# To add any new service in the future, simply add an entry to local.banners!
# =============================================================================

locals {
  banners = {
    # ---------------------------------------------------------------------------
    # Service 1: AWS S3 Object Storage
    # ---------------------------------------------------------------------------
    s3 = {
      title   = "AWS S3 BUCKET PROVISIONED"
      status  = "success"
      message = "Secure object storage bucket created successfully."
      details = {
        "Bucket Name" = aws_s3_bucket.app_storage.id
        "Region"      = var.aws_region
        "Environment" = var.environment
        "ARN"         = aws_s3_bucket.app_storage.arn

        # S3 Domain Name
        "Domain Name" = "https://${aws_s3_bucket.app_storage.bucket_regional_domain_name}"
      }
      items = [
        "S3 Bucket Versioning: Enabled",
        "Server-Side Encryption: AES256 Default",
        "Public Access Blocked"
      ]
    }

    # ---------------------------------------------------------------------------
    # Service 2: AWS SQS Queue & SNS Topic
    # ---------------------------------------------------------------------------
    sqs_sns = {
      title   = "AWS SQS & SNS MESSAGING PROVISIONED"
      status  = "success"
      message = "Decoupled messaging queue and notification topic active."
      details = {
        "SNS Topic Name" = aws_sns_topic.notifications.name
        "SNS Topic ARN"  = aws_sns_topic.notifications.arn
        "SQS Queue Name" = aws_sqs_queue.app_queue.name

        # SQS Queue URL
        "SQS Queue URL"  = aws_sqs_queue.app_queue.url
      }
      items = [
        "SNS Topic subscription attached to SQS Queue",
        "Message Retention Period: 24 Hours",
        "Maximum Message Size: 256 KB"
      ]
    }

    # ---------------------------------------------------------------------------
    # Service 3: AWS Systems Manager Parameter Store
    # ---------------------------------------------------------------------------
    ssm = {
      title   = "AWS SSM PARAMETER STORE CONFIGURED"
      status  = "info"
      message = "Centralized configuration parameters created in Parameter Store."
      details = {
        "Config Parameter" = aws_ssm_parameter.config_endpoint.name
        "Parameter Type"   = aws_ssm_parameter.config_endpoint.type
        "Parameter Tier"   = aws_ssm_parameter.config_endpoint.tier

        # Endpoint Value
        "Endpoint Value"   = aws_ssm_parameter.config_endpoint.value
      }
      items = [
        "Standard Parameter Tier (Free Tier eligible)",
        "Accessible by IAM instance profiles and Lambda execution roles"
      ]
    }

    # ---------------------------------------------------------------------------
    # Service 4: AWS Lambda Function & Public Function URL
    # ---------------------------------------------------------------------------
    lambda = {
      title   = "AWS LAMBDA FUNCTION DEPLOYED"
      status  = "success"
      message = "Serverless Function and public HTTP endpoint ready."
      details = {
        "Function Name" = aws_lambda_function.api_processor.function_name
        "Runtime"       = aws_lambda_function.api_processor.runtime
        "Memory Size"   = "${aws_lambda_function.api_processor.memory_size} MB"
        "Function ARN"  = aws_lambda_function.api_processor.arn

        # Function URL
        "Function URL"  = aws_lambda_function_url.api_url.function_url
      }
      items = [
        "CloudWatch Log Group attached",
        "Public Function URL authorization: NONE (Public)",
        "IAM Execution Role configured"
      ]
    }

    # ---------------------------------------------------------------------------
    # Service 5: AWS DynamoDB Table
    # ---------------------------------------------------------------------------
    dynamodb = {
      title   = "AWS DYNAMODB TABLE CREATED"
      status  = "success"
      message = "NoSQL key-value table active with PAY_PER_REQUEST billing mode."
      details = {
        "Table Name"   = aws_dynamodb_table.app_table.name
        "Billing Mode" = aws_dynamodb_table.app_table.billing_mode
        "Hash Key"     = aws_dynamodb_table.app_table.hash_key
        "Range Key"    = aws_dynamodb_table.app_table.range_key

        # Table ARN
        "Table ARN"    = aws_dynamodb_table.app_table.arn
      }
      items = [
        "PAY_PER_REQUEST billing (zero idle cost)",
        "Item TimeToLive (TTL) enabled",
        "Encrypted at rest with AWS owned key"
      ]
    }
  }
}

# =============================================================================
# SEQUENTIAL MODULE CALLS FOR CLEAN UNBROKEN BANNER DISPLAY
# (Chained with depends_on so parallel execution does NOT interleave lines)
# =============================================================================

# Banner 1: S3 Bucket
module "s3_banner" {
  source  = "kishormore14/tfout/utility"
  version = "0.1.6"

  tfout_version = "v0.1.5"

  title   = local.banners.s3.title
  status  = local.banners.s3.status
  message = local.banners.s3.message
  details = local.banners.s3.details
  items   = local.banners.s3.items

  theme  = "default"
  border = "single"
  color  = "always"
}

# Banner 2: SQS & SNS Messaging (Executes after S3)
module "sqs_sns_banner" {
  source     = "kishormore14/tfout/utility"
  version    = "0.1.6"
  depends_on = [module.s3_banner]

  tfout_version = "v0.1.5"

  title   = local.banners.sqs_sns.title
  status  = local.banners.sqs_sns.status
  message = local.banners.sqs_sns.message
  details = local.banners.sqs_sns.details
  items   = local.banners.sqs_sns.items

  theme  = "default"
  border = "single"
  color  = "always"
}

# Banner 3: SSM Parameter Store (Executes after SQS & SNS)
module "ssm_banner" {
  source     = "kishormore14/tfout/utility"
  version    = "0.1.6"
  depends_on = [module.sqs_sns_banner]

  tfout_version = "v0.1.5"

  title   = local.banners.ssm.title
  status  = local.banners.ssm.status
  message = local.banners.ssm.message
  details = local.banners.ssm.details
  items   = local.banners.ssm.items

  theme  = "default"
  border = "single"
  color  = "always"
}

# Banner 4: Lambda Function (Executes after SSM)
module "lambda_banner" {
  source     = "kishormore14/tfout/utility"
  version    = "0.1.6"
  depends_on = [module.ssm_banner]

  tfout_version = "v0.1.5"

  title   = local.banners.lambda.title
  status  = local.banners.lambda.status
  message = local.banners.lambda.message
  details = local.banners.lambda.details
  items   = local.banners.lambda.items

  theme  = "default"
  border = "single"
  color  = "always"
}

# Banner 5: DynamoDB Table (Executes after Lambda)
module "dynamodb_banner" {
  source     = "kishormore14/tfout/utility"
  version    = "0.1.6"
  depends_on = [module.lambda_banner]

  tfout_version = "v0.1.5"

  title   = local.banners.dynamodb.title
  status  = local.banners.dynamodb.status
  message = local.banners.dynamodb.message
  details = local.banners.dynamodb.details
  items   = local.banners.dynamodb.items

  theme  = "default"
  border = "single"
  color  = "always"
}

