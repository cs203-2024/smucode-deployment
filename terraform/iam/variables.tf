variable "config_bucket_name" {
  description = "Name of the S3 bucket containing configuration files"
  type        = string
  sensitive   = true
}

variable "aws_account_id" {
  description = "ID of AWS account"
  type        = string
  sensitive   = true
}
