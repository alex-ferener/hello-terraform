locals {
  public_az_set = toset(sort(values(var.public_subnets).*.az))
}
