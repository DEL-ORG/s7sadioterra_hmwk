provider "aws" {
  region = "us-east-1"
}

# Define a variable for tags
variable "tags" {
  description = "A map of tags to assign to resources"
  type        = map(string)
  default = {
    environment = "dev"
    project     = "demo"
    owner       = "first-lady"
  }
}

# Define a variable for user names
variable "user_names" {
  description = "A list of IAM user names to create"
  type        = list(string)
  default = [
    "developer1",
  
    "developer3",
    "developer4",
    "developer5"
  ]
}

# Create IAM users
resource "aws_iam_user" "users" {
  count = length(var.user_names)
  name  = var.user_names[count.index]
  tags  = var.tags
}

# Attach a policy to each user
resource "aws_iam_user_policy" "user_policies" {
  count = length(var.user_names)
  name  = "${var.user_names[count.index]}-policy"
  user  = aws_iam_user.users[count.index].name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = "s3:*"
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}
