output "db_sg_id" {
  description = "ID of the database security group"
  value       = aws_security_group.db_sg.id
}

output "internal_services_sg_id" {
  description = "ID of the internal services security group"
  value       = aws_security_group.internal_services_sg.id
}

output "alb_sg_id" {
  description = "IDs of ALB security groups"
  value       = aws_security_group.alb_sg.id
}

output "vpc_endpoints_sg_id" {
  description = "ID of the VPC endpoints security group"
  value       = aws_security_group.vpc_endpoints_sg.id
}
