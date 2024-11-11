variable "aws_account_id" {
  description = "ID of the AWS account"
  type        = string
}

variable "aws_region" {
  description = "Region of AWS"
  type        = string
}


variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs"
  type        = list(string)
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs"
  type        = list(string)
}

variable "internal_services_sg_id" {
  description = "ID of internal services security groups"
  type        = string
}

variable "alb_sg_id" {
  description = "ID of ALB security groups"
  type        = string
}

variable "db_addresses" {
  description = "Map of DB Ids to their respective addresses"
  type        = map(string)
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

variable "ecs_execution_role_arn" {
  description = "ECS execution role ARN"
  type        = string
  sensitive   = true
}

variable "ecs_task_role_arn" {
  description = "ECS task role ARN"
  type        = string
  sensitive   = true
}

variable "services" {
  description = "Service defintions for ECS"
  type = map(object({
    name = string
    port = number
  }))
}

variable "fargate_cpu" {
  description = "Fargate instance CPU units to provision (1 vCPU = 1024 CPU units)"
  type        = number
  default     = 1024 # Increase to 1 vCPU
}

variable "fargate_memory" {
  description = "Fargate instance memory to provision (in MiB)"
  type        = number
  default     = 2048 # Increase to 2 GB
}

variable "aws_config_bucket_name" {
  description = "Name of the S3 bucket for configuration files"
  type        = string
  sensitive   = true
}

variable "aws_access_key" {
  description = "Access Key for the app to communicate with AWS services"
  type        = string
  sensitive   = true
}

variable "aws_secret_access_key" {
  description = "Secret Key for the app to communicate with AWS services"
  type        = string
  sensitive   = true
}

variable "jwt_public_key" {
  description = "Public key for JWT decoding for auth service"
  type        = string
  sensitive   = true
}

variable "jwt_key_id" {
  description = "UUID for JWT operations for auth service "
  type        = string
  sensitive   = true
}

variable "feign_access_token" {
  description = "Access token for microservices to communicate internally"
  type        = string
  sensitive   = true
}
