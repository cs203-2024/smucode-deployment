resource "aws_security_group" "vpc_endpoints_sg" {
  name        = "brawlcode-vpc-endpoints-sg"
  description = "Security group for VPC endpoints"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    from_port   = 443 # HTTPS required for AWS APIs
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.vpc.cidr_block]
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
