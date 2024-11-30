resource "aws_subnet" "public" {
  for_each              = var.public_subnet_cidrs
  vpc_id                = aws_vpc.main.id
  cidr_block            = each.value
  availability_zone     = each.key
  map_public_ip_on_launch = true

  tags = {
    Name = "Public-Subnet-${each.key}"
  }
}

resource "aws_subnet" "private" {
  for_each              = var.private_subnet_cidrs
  vpc_id                = aws_vpc.main.id
  cidr_block            = each.value
  availability_zone     = each.key

  tags = {
    Name = "Private-Subnet-${each.key}"
  }
}

