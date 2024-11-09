resource "aws_security_group" "vpc_endpoints_sg" {
  name        = "brawlcode-vpc-endpoints-sg"
  description = "Security group for VPC endpoints"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 443 # HTTPS required for AWS APIs
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
  }

  egress {
    from_port   = 0 # Allow all outbound
    to_port     = 0
    protocol    = "-1" # allow all protocols
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "brawlcode-vpc-endpoints-sg"
  }
}

resource "aws_security_group" "alb_sg" {
  name        = "brawlcode-alb-sg"
  description = "Security group for EC2 ALB"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0 # Allow all outbound
    to_port     = 0
    protocol    = "-1" # allow all protocols
    cidr_blocks = ["0.0.0.0/0"]
  }


  tags = {
    Name = "brawlcode-alb-sg"
  }
}

resource "aws_security_group" "internal_services_sg" {
  name        = "brawlcode-internal-services-sg"
  description = "Security group for internal microservices"
  vpc_id      = var.vpc_id

  ingress {
    description     = "API Gateway access from ALB"
    from_port       = 9000
    to_port         = 9000
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_sg.id]
  }

  # Add internal container communication
  # - Service Registry (Eureka) on 8761
  # - Config Service on 8888
  # - Auth Service on 8000
  # - User Service on 8080
  # - Tournament Service on 8081
  # - Notification Service on 8082
  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    self      = true
  }

  # Allow all outbound
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "brawlcode-internal-services-sg"
  }
}


resource "aws_security_group" "db_sg" {
  name        = "brawlcode-db-sg"
  description = "Security group for RDS database"
  vpc_id      = var.vpc_id

  ingress {
    description     = "PostgreSQL access from services"
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [aws_security_group.internal_services_sg.id]
  }

  # No egress needed for DB, but added for completeness
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "brawlcode-db-sg"
  }
}
