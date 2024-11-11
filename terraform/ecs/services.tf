locals {
  service_to_db_map = {
    "auth-service"         = "auth_db"
    "user-service"         = "user_db"
    "tournament-service"   = "tournament_db"
    "notification-service" = "notification_db"
  }
}

# task definition
resource "aws_ecs_task_definition" "services" {
  for_each = var.services

  family                   = "brawlcode-${each.value.name}"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = var.fargate_cpu
  memory                   = var.fargate_memory
  execution_role_arn       = var.ecs_execution_role_arn
  task_role_arn            = var.ecs_task_role_arn

  container_definitions = templatefile("${path.module}/../templates/ecs_json.tftpl", {
    app_name       = each.value.name
    aws_account_id = var.aws_account_id
    aws_region     = var.aws_region
    fargate_cpu    = var.fargate_cpu
    fargate_memory = var.fargate_memory
    app_port       = each.value.port
    log_group      = aws_cloudwatch_log_group.ecs_logs.name

    requires_service_discovery = contains(["api-gateway", "auth-service", "user-service", "tournament-service", "notification-service", "api-gateway"], each.value.name)

    database_config = contains(["auth-service", "user-service", "tournament-service", "notification-service"], each.value.name) ? {
      host     = var.db_addresses[local.service_to_db_map[each.value.name]]
      port     = 5432
      name     = local.service_to_db_map[each.value.name]
      username = var.db_username
      password = var.db_password
    } : null

    AWS_CONFIG_BUCKET_NAME = var.aws_config_bucket_name
    AWS_ACCESS_KEY         = var.aws_access_key
    AWS_SECRET_ACCESS_KEY  = var.aws_secret_access_key
    JWT_PUBLIC_KEY         = var.jwt_public_key
    JWT_KEY_ID             = var.jwt_key_id
    FEIGN_ACCESS_TOKEN     = var.feign_access_token
  })
}

resource "aws_ecs_service" "services" {
  for_each = var.services

  name            = "brawlcode-${each.value.name}"
  cluster         = aws_ecs_cluster.cluster.id
  task_definition = aws_ecs_task_definition.services[each.key].arn
  launch_type     = "FARGATE"
  desired_count   = 1

  network_configuration {
    subnets          = var.private_subnet_ids
    security_groups  = [var.internal_services_sg_id]
    assign_public_ip = true
  }

  # Only attach to ALB if it's the API Gateway
  dynamic "load_balancer" {
    for_each = each.value.name == "api-gateway" ? [1] : []
    content {
      target_group_arn = aws_lb_target_group.api_gateway.arn
      container_name   = each.value.name
      container_port   = each.value.port
    }
  }

  service_registries {
    registry_arn = aws_service_discovery_service.services[each.key].arn
  }
}

resource "aws_service_discovery_service" "services" {
  for_each = var.services

  name = each.value.name

  dns_config {
    namespace_id = aws_service_discovery_private_dns_namespace.main.id

    dns_records {
      ttl  = 10
      type = "A"
    }

    routing_policy = "MULTIVALUE"
  }

  health_check_custom_config {
    failure_threshold = 1
  }
}
