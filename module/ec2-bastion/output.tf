# Output subnet IDs for verification
output "public_subnet_ids" {
  value = data.aws_subnet.public.id
}

output "private_subnet_ids" {
  value = data.aws_subnet.private.id
}