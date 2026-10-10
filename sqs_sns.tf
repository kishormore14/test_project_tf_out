# -----------------------------------------------------------------------------
# AWS SQS Queue & SNS Topic Resources
# -----------------------------------------------------------------------------

# 1. AWS SNS Topic
resource "aws_sns_topic" "notifications" {
  name = "${var.project_name}-topic-${random_string.suffix.result}"
}

# 2. AWS SQS Queue
resource "aws_sqs_queue" "app_queue" {
  name                      = "${var.project_name}-queue-${random_string.suffix.result}"
  delay_seconds             = 0
  max_message_size          = 262144
  message_retention_seconds = 86400
  receive_wait_time_seconds = 10
}

# 3. Subscribe SQS to SNS
resource "aws_sns_topic_subscription" "queue_subscription" {
  topic_arn = aws_sns_topic.notifications.arn
  protocol  = "sqs"
  endpoint  = aws_sqs_queue.app_queue.arn
}
