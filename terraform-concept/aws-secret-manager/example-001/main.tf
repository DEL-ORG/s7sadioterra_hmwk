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
  }
}

# Create an AWS Secrets Manager secret
resource "aws_secretsmanager_secret" "example_secret_holder" {
  name        = "example-secret-holder" # Name of the secret
  description = "This is an example secret for demonstration purposes"
  tags        = var.tags
}

# Add a secret value to the Secrets Manager secret
resource "aws_secretsmanager_secret_version" "example_secret_holder_version" {
  secret_id = aws_secretsmanager_secret.example_secret_holder.id
  secret_string = jsonencode({
  
  })
}
