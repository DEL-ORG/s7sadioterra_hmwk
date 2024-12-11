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

# Define a list of secret names
variable "secret_names" {
  description = "A list of secret names to create as placeholders"
  type        = list(string)
  default     = [
    "DB_USERNAME",
    "DB_PASSWORD"
  ]
}

# Create placeholder secrets using for_each
resource "aws_secretsmanager_secret" "placeholders" {
  for_each   = toset(var.secret_names)  # Use for_each with the list of names
  name       = each.key                # Use each.key to set the secret name
  description = "This is a placeholder secret with no value."
  tags       = var.tags
}
