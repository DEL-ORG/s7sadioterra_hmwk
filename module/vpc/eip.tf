# Create Elastic IPs for NAT Gateways
resource "aws_eip" "nat" {
  for_each = var.public_subnet_cidrs
 

  tags = merge(var.tags, { Name = "NAT-EIP-${each.key}" })
}