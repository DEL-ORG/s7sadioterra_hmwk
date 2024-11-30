resource "aws_nat_gateway" "nat" {
  for_each   = aws_subnet.public
  allocation_id = aws_eip.nat[each.key].id
  subnet_id     = each.value.id

  tags = {
    Name = "NAT-Gateway-${each.key}"
  }
}
