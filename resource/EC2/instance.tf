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
 ami_id        = "ami-063d43db0594b521b"  # Replace with a valid AMI ID
instance_type = "t2.micro"
region        = "us-east-1"
key_name      = "women-power"  
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
ami_id        = local. ami_id  
instance_type = local.instance_type
region        = "us-east-1"
key_name      = "women-power"  

}