variable "aws_region" {
  description = "Region of AWS"
  default     = "ap-southeast-1"
  type        = string
}

variable "aws_account_id" {
  description = "AWS Account ID"
  type        = string
  sensitive   = true
}

variable "db_username" {
  description = "Username for the DBs"
  type        = string
  sensitive   = true
}

variable "db_password" {
  description = "Password for the DBs"
  type        = string
  sensitive   = true
}

variable "config_bucket_name" {
  description = "Name of the S3 bucket for configuration files"
  type        = string
  sensitive   = true
}
