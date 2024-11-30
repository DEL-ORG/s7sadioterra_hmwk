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
rep_region = "us-east-2"
region = "us-east-1"
force_destroy = true 
}
module "s3-backend" {
  source      = "../../module/S3backend"
tags = local.tags
rep_region = "us-east-2"
region = "us-east-1"
force_destroy = true 
}