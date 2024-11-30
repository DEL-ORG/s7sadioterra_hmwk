variable "tags" {
  description = "A map of tags to assign to resources"
  type        = map(string)
  default     = {
    environment = "dev"
    project  = "demo"
    owner    = "first-lady"
  }
}

variable "rep_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-2"
}

variable "region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "force_destroy"{
   type = bool
}