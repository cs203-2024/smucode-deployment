resource "aws_ecs_cluster" "cluster" {
  name = "brawlcode-cluster"

  # to monitor containers
  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

resource "aws_ecs_cluster_capacity_providers" "main" {
  cluster_name       = aws_ecs_cluster.cluster.name
  capacity_providers = ["FARGATE"]

  default_capacity_provider_strategy {
    capacity_provider = "FARGATE"
    weight            = 1
  }
}

resource "aws_cloudwatch_log_group" "ecs_logs" {
  name              = "/ecs/brawlcode"
  retention_in_days = 30
}

resource "aws_service_discovery_private_dns_namespace" "main" {
  name        = "brawlcode.prod"
  description = "Private DNS namespace for Brawlcode services"
  vpc         = var.vpc_id
}
