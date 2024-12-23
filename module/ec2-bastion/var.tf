# Variables
variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}
variable "region" {
  type        = string
}
variable "public_subnet_cidrs" {
  description = "Map of availability zones to public subnet CIDR blocks"
  type        = map(string)
}

variable "private_subnet_cidrs" {
  description = "Map of availability zones to private subnet CIDR blocks"
  type        = map(string)
  default = {
    "us-east-1a" = "10.0.101.0/24"
    "us-east-1b" = "10.0.102.0/24"
    "us-east-1c" = "10.0.103.0/24"
  }
}

variable "tags" {
  description = "A map of tags to assign to resources"
  type        = map(string)
  
}
variable "instance_type" {
  description = "create the instance"
  type        = string
}
variable "key_name" {
  description = "create the instance"
  type        = string
  
}
