variable "vpc_cidr_block" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "vpc_endpoints_sg_id" {
  description = "Security group of VPC endpoints"
  type        = string
}
