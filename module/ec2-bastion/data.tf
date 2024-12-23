data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"] # Canonical
}
# Fetch VPC by tag or ID
data "aws_vpc" "main" {
  filter {
    name   = "tag:environment"
    values = ["dev"]
  }
}

# Fetch public subnets based on tags and VPC ID
data "aws_subnet" "public" {
  filter {
    name   = "tag:Name"
    values = ["Public-Subnet-us-east-1a"]
  }
}

# Fetch private subnets based on tags and VPC ID
data "aws_subnet" "private" {
  filter {
    name   = "tag:Name"
    values = ["Private-Subnet-us-east-1a"]
  }
}


# data "aws_security_group" "existing_sg" {
# name = "jurist-group"
# }