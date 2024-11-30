terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"  # Use version 4.x of the AWS provider
    }
  }

  required_version = ">= 1.0.0"  # Specify Terraform version if needed
}

locals  {
 tags = {
    environment = "dev"
    project  = "demo"
    owner    = "first-lady"
  }
  region = "us-east-1"
  public_subnet_cidrs = {
    "us-east-1a" = "10.0.1.0/24"
    "us-east-1b" = "10.0.2.0/24"
    "us-east-1c" = "10.0.3.0/24"
  }
  vpc_cidr = "10.0.0.0/16"
}

module "vpc" {
  source               = "../../module/vpc"
  tags                 = local.tags
  region               = local.region
  public_subnet_cidrs = local.public_subnet_cidrs
  vpc_cidr = local.vpc_cidr
}
