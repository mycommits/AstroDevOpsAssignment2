module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.5"

  name                         = local.vpc.name
  cidr                         = local.vpc.cidr
  create_igw                   = local.vpc.create_igw
  enable_ipv6                  = local.vpc.enable_ipv6
  create_egress_only_igw       = local.vpc.create_egress_only_igw
  create_database_subnet_group = local.vpc.create_database_subnet_group

  azs                     = local.vpc.azs
  public_subnets          = local.vpc.public_subnets
  public_subnet_names     = local.vpc.public_subnet_names
  private_subnets         = local.vpc.private_subnets
  private_subnet_names    = local.vpc.private_subnet_names
  enable_nat_gateway      = local.vpc.enable_nat_gateway
  single_nat_gateway      = local.vpc.single_nat_gateway
  enable_dns_support      = local.vpc.enable_dns_support
  enable_dns_hostnames    = local.vpc.enable_dns_hostnames
  map_public_ip_on_launch = local.vpc.map_public_ip_on_launch

  igw_tags            = local.vpc.igw_tags
  nat_gateway_tags    = local.vpc.nat_gateway_tags
  public_subnet_tags  = local.vpc.public_subnet_tags
  private_subnet_tags = local.vpc.private_subnet_tags
  tags                = local.vpc.tags
}