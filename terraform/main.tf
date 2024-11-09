module "vpc" {
  source = "./vpc"
}

module "ec2" {
  source   = "./ec2"
  vpc_id   = module.vpc.vpc_id
  vpc_cidr = module.vpc.vpc_cidr
}

module "iam" {
  source             = "./iam"
  config_bucket_name = var.config_bucket_name
}

module "rds" {
  source = "./rds"

  db_username       = var.db_username
  db_password       = var.db_password
  db_sg_id          = module.ec2.db_sg_id
  subnet_group_name = module.vpc.db_subnet_group_name

  databases = {
    "user-db" = {
      identifier = "brawlcode-user-db"
    }
    "tournament-db" = {
      identifier = "brawlcode-tournament-db"
    }
    "auth-db" = {
      identifier = "brawlcode-auth-db"
    }
    "notification-db" = {
      identifier = "brawlcode-notification-db"
    }
  }
}

module "ecs" {
  source = "./ecs"

  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
  alb_sg_ids        = module.ec2.alb_sg_ids
}
