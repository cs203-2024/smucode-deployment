resource "aws_vpc_endpoint" "s3" {
  vpc_id            = aws_vpc.vpc.id
  service_name      = "com.amazonaws.ap-southeast-1.s3"
  vpc_endpoint_type = "Gateway"
  route_table_ids = [
    aws_route_table.private_route_table.id
  ]

  tags = {
    Name = "brawlcode-s3-endpoint"
  }
}
