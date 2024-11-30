terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"  # Use version 4.x of the AWS provider
    }
  }
required_version = ">= 1.0.0"  # Specify Terraform version if needed
}

provider "aws" {
  region = var.region  # Change the region as needed
  alias = "source"
}

provider "aws" {
  region = var.rep_region  # Change the region as needed
alias = "target"
}