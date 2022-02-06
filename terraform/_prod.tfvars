aws_region = "eu-central-1"
name       = "hello"

vpc = {
  cidr_block = "172.30.0.0/16"

  public_subnets = {
    "ingress-1a" = {
      cidr = "172.30.48.0/24"
      az   = "eu-central-1a"
    }
    "ingress-1b" = {
      cidr = "172.30.49.0/24"
      az   = "eu-central-1b"
    }
    "ingress-1c" = {
      cidr = "172.30.50.0/24"
      az   = "eu-central-1c"
    }
  }

  private_subnets = {
    "eks-nat-1a" = {
      cidr = "172.30.0.0/20"
      az   = "eu-central-1a"
    }
    "eks-nat-1b" = {
      cidr = "172.30.16.0/20"
      az   = "eu-central-1b"
    }
    "eks-nat-1c" = {
      cidr = "172.30.32.0/20"
      az   = "eu-central-1c"
    }
  }

  isolated_subnets = {
    "db-1a" = {
      cidr = "172.30.51.0/24"
      az   = "eu-central-1a"
    }
    "db-1b" = {
      cidr = "172.30.52.0/24"
      az   = "eu-central-1b"
    }
    "db-1c" = {
      cidr = "172.30.53.0/24"
      az   = "eu-central-1c"
    }
  }
}

eks = {
  version                 = "1.21"
  endpoint_private_access = true
  endpoint_public_access  = true
  public_access_cidrs     = ["0.0.0.0/0"]
  service_ipv4_cidr       = "10.100.0.0/16"
}

tags = {
  "project" : "hello"
}
