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

variable "AWS_CONFIG_BUCKET_NAME" {
  description = "Name of the S3 bucket for configuration files"
  type        = string
  sensitive   = true
}

variable "AWS_ACCESS_KEY" {
  description = "Access Key for the app to communicate with AWS services"
  type        = string
  sensitive   = true
}

variable "AWS_SECRET_ACCESS_KEY" {
  description = "Secret Key for the app to communicate with AWS services"
  type        = string
  sensitive   = true
}

variable "JWT_PUBLIC_KEY" {
  description = "Public key for JWT decoding for auth service"
  type        = string
  sensitive   = true
}

variable "JWT_KEY_ID" {
  description = "UUID for JWT operations for auth service "
  type        = string
  sensitive   = true
}

variable "FEIGN_ACCESS_TOKEN" {
  description = "Access token for microservices to communicate internally"
  type        = string
  sensitive   = true
}
