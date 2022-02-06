module "vpc" {
  source = "./modules/vpc"

  vpc_cidr_block   = var.vpc_cidr_block
  public_subnets   = var.public_subnets
  private_subnets  = var.private_subnets
  isolated_subnets = var.isolated_subnets

  tags = merge(var.tags, {
    Name = "hello"
  })
}
