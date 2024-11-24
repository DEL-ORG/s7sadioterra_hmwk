# variables.tf

variable "instance_type" {
  description = "Type of EC2 instance"
  type        = string
  default     = "t2.micro"
}

variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
  default = "ami-063d43db0594b521b"
}

variable "region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}



variable "key_name" {
  description = "The SSH key pair name to use for the instance"
  type        = string
  default = "women-power"
  
}


variable "tags" {
  description = "A map of tags to assign to resources"
  type        = map(string)
  default     = {
    Name     = "exampleec2instance"
    Project  = "Demo"
    Owner    = "K. Sacko"
  }
}

