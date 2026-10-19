# =============================================================================
# TFOUT BANNER FOR AWS LAMBDA
# =============================================================================

locals {
  banners = {
    lambda = {
      title   = "AWS LAMBDA FUNCTION DEPLOYED"
      status  = "success"
      message = "Serverless Function and public HTTP endpoint ready."
      details = {
        "Function Name" = aws_lambda_function.api_processor.function_name
        "Runtime"       = aws_lambda_function.api_processor.runtime
        "Memory Size"   = "${aws_lambda_function.api_processor.memory_size} MB"
        "Function ARN"  = aws_lambda_function.api_processor.arn
        "Function URL"  = aws_lambda_function_url.api_url.function_url
      }
      items = [
        "CloudWatch Log Group attached",
        "Public Function URL authorization: NONE (Public)",
        "IAM Execution Role configured"
      ]
    }
  }
}

# Banner: Lambda Function
module "lambda_banner" {
  source  = "kishormore14/tfout/utility"
  version = "0.1.7"

  tfout_version = "v0.1.6"

  title   = local.banners.lambda.title
  status  = local.banners.lambda.status
  message = local.banners.lambda.message
  details = local.banners.lambda.details
  items   = local.banners.lambda.items

  theme  = "default"
  border = "single"
  color  = "always"
}
