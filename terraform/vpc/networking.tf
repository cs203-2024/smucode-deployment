resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "brawlcode-igw"
  }
}

resource "aws_eip" "nat_eip" {
  tags = {
    Name = "brawlcode-nat-eip-1"
  }
}

resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_subnet_1.id

  tags = {
    Name = "brawlcode-nat-gw"
  }
}
