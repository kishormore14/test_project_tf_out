variable "aws_region" {
  type        = string
  default     = "ap-south-1"
  description = "AWS Region to deploy resources into"
}

variable "aws_profile" {
  type        = string
  default     = "kishorAccount"
  description = "AWS CLI named profile"
}

variable "environment" {
  type        = string
  default     = "production"
  description = "Deployment environment name"
}

variable "project_name" {
  type        = string
  default     = "my-app-storage"
  description = "Base project name for S3 bucket"
}
