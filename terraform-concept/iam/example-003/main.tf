provider "aws" {
  region = "us-east-1"
}

# Define a variable for tags
variable "tags" {
  description = "A map of tags to assign to resources"
  type        = map(string)
  default     = {
    environment = "dev"
    project     = "demo"
    owner       = "first-lady"
  }
}

# Define a variable for user names
variable "user_names" {
  description = "A list of IAM user names to create"
  type        = list(string)
  default     = [
    "developer1",
    "developer3",
    "developer4",
    "developer5",
    "developer2"
  ]
}

# Create IAM users
resource "aws_iam_user" "users" {
  for_each = toset(var.user_names)
  name     = each.key
  tags     = var.tags
}

# Create an IAM group
resource "aws_iam_group" "excellents_group" {
  name = "EXELLENTS_GROUP"
}

# Attach the Admin policy to the group
resource "aws_iam_group_policy_attachment" "admin_policy" {
  group      = aws_iam_group.excellents_group.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess" # aws management policy
}

# Add users to the group
resource "aws_iam_group_membership" "group_membership" {
  name  = "EXELLENTS_GROUP_membership" # Unique name for the membership
  group = aws_iam_group.excellents_group.name
  users = [for user in keys(aws_iam_user.users) : aws_iam_user.users[user].name]
}
