# -----------------------------------------------------------------------------
# Lambda Outputs
# -----------------------------------------------------------------------------

output "lambda_function_name" {
  value       = aws_lambda_function.api_processor.function_name
  description = "Name of deployed Lambda function"
}

output "lambda_function_url" {
  value       = aws_lambda_function_url.api_url.function_url
  description = "Public URL endpoint for Lambda function"
}

output "lambda_arn" {
  value       = aws_lambda_function.api_processor.arn
  description = "ARN of deployed Lambda function"
}
