module "vpc" {
  source = "./modules/vpc"

  vpc_cidr_block   = var.vpc.cidr_block
  public_subnets   = var.vpc.public_subnets
  private_subnets  = var.vpc.private_subnets
  isolated_subnets = var.vpc.isolated_subnets

  tags = merge(var.tags, {
    Name = var.name
  })
}
