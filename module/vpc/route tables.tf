# Create Route Tables for Public Subnets
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = merge(var.tags, { Name = "Public-RouteTable" })
}

# Associate Public Subnets with Public Route Table
resource "aws_route_table_association" "public" {
  for_each      = aws_subnet.public
  subnet_id      = each.value.id
  route_table_id = aws_route_table.public.id
}

# Create Route Tables for Private Subnets
resource "aws_route_table" "private" {
  for_each = aws_subnet.private
  vpc_id   = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat[each.key].id
  }

  tags = merge(var.tags, { Name = "Private-RouteTable-${each.key}" })
}

# Associate Private Subnets with Private Route Tables
resource "aws_route_table_association" "private" {
  for_each      = aws_subnet.private
  subnet_id      = each.value.id
  route_table_id = aws_route_table.private[each.key].id
}