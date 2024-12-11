provider "aws" {
  region = "us-east-1"
}

# Define tags as a variable
variable "tags" {
  description = "A map of tags to assign to resources"
  type        = map(string)
  default     = {
    environment = "dev"
    project     = "demo"
    owner       = "first-lady"
    Name        = "developer_user"
    created_by  ="terraform"  
  }
}

# Create an IAM user
resource "aws_iam_user" "developer_user" {
  name = "developer-user"

  tags = var.tags
}

# Attach a policy to the user (optional)
resource "aws_iam_user_policy" "developer_policy" {
  name = "developer-user-policy"
  user = aws_iam_user.developer_user.name

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


