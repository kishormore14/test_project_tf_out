# -----------------------------------------------------------------------------
# Main Terraform Configuration File for test_s3_project
# Modular structure:
# - providers.tf  : Provider requirements & AWS config
# - backend.tf    : Remote S3 backend & native lockfile state configuration
# - variables.tf  : Input variables
# - s3.tf         : AWS S3 bucket resources & common_tags definition
# - sqs_sns.tf    : AWS SQS Queue & SNS Topic resources
# - ssm.tf        : AWS SSM Parameter Store resources
# - lambda.tf     : AWS Lambda Function & Function URL
# - dynamodb.tf   : AWS DynamoDB Table
# - banners.tf    : tfout status banners module calls
# - outputs.tf    : Output definitions
# -----------------------------------------------------------------------------
