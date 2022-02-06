variable "name" {
  description = "The Name of EKS cluster"
  type        = string
}

variable "ver" {
  description = "Desired Kubernetes master version"
  type        = string
}

variable "private_subnets_ids" {
  description = "A list with private subnets IDs"
  type        = list(string)
}

variable "endpoint_private_access" {
  description = "Whether the Amazon EKS private API server endpoint is enabled"
  type        = bool
}

variable "endpoint_public_access" {
  description = "Whether the Amazon EKS public API server endpoint is enabled"
  type        = bool
}

variable "public_access_cidrs" {
  description = "Indicates which CIDR blocks can access the Amazon EKS public API server endpoint when enabled"
  type        = list(string)
}

variable "service_ipv4_cidr" {
  description = "The CIDR block to assign Kubernetes service IP addresses from"
  type        = string
}

variable "tags" {
  description = "All resources created by this module will be tagged with these tags"
  type        = map(string)
  default     = {}
}
