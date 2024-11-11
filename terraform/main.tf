module "vpc" {
  source              = "./vpc"
  vpc_endpoints_sg_id = module.ec2.vpc_endpoints_sg_id
}

module "ec2" {
  source   = "./ec2"
  vpc_id   = module.vpc.vpc_id
  vpc_cidr = module.vpc.vpc_cidr
}

module "iam" {
  source             = "./iam"
  config_bucket_name = var.AWS_CONFIG_BUCKET_NAME
  aws_account_id     = var.aws_account_id
}

module "rds" {
  source = "./rds"

  db_username       = var.db_username
  db_password       = var.db_password
  db_sg_id          = module.ec2.db_sg_id
  subnet_group_name = module.vpc.db_subnet_group_name

  databases = {
    "user_db" = {
      identifier = "brawlcode-user-db"
    }
    "tournament_db" = {
      identifier = "brawlcode-tournament-db"
    }
    "auth_db" = {
      identifier = "brawlcode-auth-db"
    }
    "notification_db" = {
      identifier = "brawlcode-notification-db"
    }
  }
}

module "ecs" {
  source = "./ecs"

  aws_region     = var.aws_region
  aws_account_id = var.aws_account_id

  vpc_id             = module.vpc.vpc_id
  public_subnet_ids  = module.vpc.public_subnet_ids
  private_subnet_ids = module.vpc.private_subnet_ids

  alb_sg_id               = module.ec2.alb_sg_id
  internal_services_sg_id = module.ec2.internal_services_sg_id

  db_addresses = module.rds.db_addresses
  db_username  = var.db_username
  db_password  = var.db_password

  ecs_task_role_arn      = module.iam.ecs_task_role_arn
  ecs_execution_role_arn = module.iam.ecs_execution_role_arn

  aws_config_bucket_name = var.AWS_CONFIG_BUCKET_NAME
  aws_access_key         = var.AWS_ACCESS_KEY
  aws_secret_access_key  = var.AWS_SECRET_ACCESS_KEY
  jwt_public_key         = var.JWT_PUBLIC_KEY
  jwt_key_id             = var.JWT_KEY_ID
  feign_access_token     = var.FEIGN_ACCESS_TOKEN

  services = {
    "service-registry" = {
      name = "service-registry"
      port = 8761
    }
    "config-service" = {
      name = "config-service"
      port = 8888
    }
    "api-gateway" = {
      name                       = "api-gateway"
      port                       = 9000
      requires_service_discovery = true
    }
    "auth-service" = {
      name                       = "auth-service"
      port                       = 8000
      requires_service_discovery = true
    }
    "user-service" = {
      name                       = "user-service"
      port                       = 8080
      requires_service_discovery = true
    }
    "tournament-service" = {
      name                       = "tournament-service"
      port                       = 8081
      requires_service_discovery = true
    }
    "notification-service" = {
      name                       = "notification-service"
      port                       = 8082
      requires_service_discovery = true
    }
  }
}
