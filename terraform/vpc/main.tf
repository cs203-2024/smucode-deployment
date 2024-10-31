resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = true # needed for eureka, utilising hostnames
  enable_dns_support   = true # needed for resolving of service dns

  tags = {
    Name = "brawlcode-vpc"
  }
}
