# -----------------------------------------------------------------------------
# AWS Lambda Function & Function URL Resources
# -----------------------------------------------------------------------------

# 1. IAM Execution Role for Lambda
resource "aws_iam_role" "lambda_exec" {
  name = "${var.project_name}-exec-role-${random_string.suffix.result}"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action    = "sts:AssumeRole"
      Effect    = "Allow"
      Principal = { Service = "lambda.amazonaws.com" }
    }]
  })
}

# 2. Attach CloudWatch Logs Policy
resource "aws_iam_role_policy_attachment" "lambda_logs" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

# 3. Zip Inline Lambda Code
data "archive_file" "lambda_zip" {
  type        = "zip"
  output_path = "${path.module}/lambda_function.zip"

  source {
    content  = "exports.handler = async () => ({ statusCode: 200, body: JSON.stringify({ message: 'Hello from Lambda!' }) });"
    filename = "index.js"
  }
}

# 4. Create Lambda Function
resource "aws_lambda_function" "api_processor" {
  filename         = data.archive_file.lambda_zip.output_path
  function_name    = "${var.project_name}-fn-${random_string.suffix.result}"
  role             = aws_iam_role.lambda_exec.arn
  handler          = "index.handler"
  runtime          = "nodejs18.x"
  memory_size      = 128
  timeout          = 10
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256
}

# 5. Create Public Function URL
resource "aws_lambda_function_url" "api_url" {
  function_name      = aws_lambda_function.api_processor.function_name
  authorization_type = "NONE"
}
