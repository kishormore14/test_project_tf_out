# S3 Outputs
output "s3_bucket_name" {
  value       = aws_s3_bucket.app_storage.id
  description = "Name of the created S3 bucket"
}

output "s3_bucket_arn" {
  value       = aws_s3_bucket.app_storage.arn
  description = "ARN of the created S3 bucket"
}

output "s3_domain_name" {
  value       = aws_s3_bucket.app_storage.bucket_regional_domain_name
  description = "Regional domain name of the created S3 bucket"
}

# SQS & SNS Outputs
output "sqs_queue_url" {
  value       = aws_sqs_queue.app_queue.url
  description = "URL of the created SQS queue"
}

output "sns_topic_arn" {
  value       = aws_sns_topic.notifications.arn
  description = "ARN of the created SNS topic"
}

# SSM Outputs
output "ssm_parameter_endpoint" {
  value       = aws_ssm_parameter.config_endpoint.name
  description = "Name of SSM configuration endpoint parameter"
}

# Lambda Outputs
output "lambda_function_name" {
  value       = aws_lambda_function.api_processor.function_name
  description = "Name of deployed Lambda function"
}

output "lambda_function_url" {
  value       = aws_lambda_function_url.api_url.function_url
  description = "Public URL endpoint for Lambda function"
}

# DynamoDB Outputs
output "dynamodb_table_name" {
  value       = aws_dynamodb_table.app_table.name
  description = "Name of created DynamoDB table"
}

output "dynamodb_table_arn" {
  value       = aws_dynamodb_table.app_table.arn
  description = "ARN of created DynamoDB table"
}
