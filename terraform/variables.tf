variable "aws_region" {
  description = "AWS Region"
  type        = string
}

variable "name" {
  description = "Project name"
  type        = string
}

variable "vpc" {
  description = "VPC configuration"
  type = object({
    cidr_block       = string
    public_subnets   = map(map(string))
    private_subnets  = map(map(string))
    isolated_subnets = map(map(string))
  })
}

variable "tags" {
  description = "All resources will be tagged with these tags"
  type        = map(string)
  default     = {}
}
