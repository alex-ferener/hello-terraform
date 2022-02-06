variable "vpc_cidr_block" {
  description = "VPC CIDR block"
  type        = string
}

variable "public_subnets" {
  description = "A map with public subnets"
  type        = map(map(string))
}

variable "private_subnets" {
  description = "A map with private subnets (with NAT)"
  type        = map(map(string))
}

variable "isolated_subnets" {
  description = "A map with isolated subnets (without Internet access)"
  type        = map(map(string))
}

variable "tags" {
  description = "All resources created by this module will be tagged with these tags"
  type        = map(string)
  default     = {}
}
