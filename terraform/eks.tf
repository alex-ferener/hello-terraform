module "eks" {
  source = "./modules/eks"

  name                    = var.name
  ver                     = var.eks.version
  private_subnets_ids     = values(module.vpc.private_subnets)
  endpoint_private_access = var.eks.endpoint_public_access
  endpoint_public_access  = var.eks.endpoint_private_access
  public_access_cidrs     = var.eks.public_access_cidrs
  service_ipv4_cidr       = var.eks.service_ipv4_cidr

  tags = var.tags
}
