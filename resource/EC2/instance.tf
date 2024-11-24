terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"  # Use version 4.x of the AWS provider
    }
  }

  required_version = ">= 1.0.0"  # Specify Terraform version if needed
}

variable "region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}
  terraform {
  backend "s3" {
    bucket         = "dev-demo-first-lady-tf-state"
    key            = "module/ec2-module/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "dev-demo-first-lady-tf-state-lock"
    encrypt        = true
  }
  }

module "ec2-module" {
  source      = "../../module/ec2-module"
# aws_region  = local.aws_region
#common_tags = local.common_tags

}