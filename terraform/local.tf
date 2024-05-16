locals {
  region = var.region

  vpc = {
    name                               = join("-", [var.name, var.region])
    cidr                               = var.vpc_cidr
    create_igw                         = var.vpc_create_igw
    enable_ipv6                        = var.vpc_enable_ipv6
    create_egress_only_igw             = var.vpc_create_egress_only_igw
    create_database_subnet_group       = var.vpc_create_database_subnet_group
    azs                                = lookup(var.vpc_azs, var.region)
    public_subnets                     = var.vpc_public_subnets
    public_subnet_names                = [join("-", [var.name, var.region, "public"])]
    private_subnet_names               = [join("-", [var.name, var.region, "private"])]
    private_subnets                    = var.vpc_private_subnets
    enable_nat_gateway                 = var.vpc_enable_nat_gateway
    single_nat_gateway                 = var.vpc_single_nat_gateway
    nat_gateway_destination_cidr_block = var.vpc_nat_gateway_destination_cidr_block
    enable_dns_support                 = var.vpc_enable_dns_support
    enable_dns_hostnames               = var.vpc_enable_dns_hostnames
    map_public_ip_on_launch            = var.vpc_map_public_ip_on_launch

    igw_tags = {
      Name = join("-", [var.name, var.region, "igw"])
    }
    nat_gateway_tags = {
      Name = join("-", [var.name, var.region, "natgw"])
    }
    public_subnet_tags = {
      Type = "internet"
    }
    private_subnet_tags = {
      Type = "internal"
    }
    tags = {
      Terraform   = "true"
      Environment = "dev"
      Workload    = "3Tier-APP"
    }
  }

  eks = {
    cluster_name                         = var.eks_cluster_name
    cluster_version                      = var.eks_cluster_version
    cluster_endpoint_public_access       = var.eks_cluster_endpoint_public_access
    cluster_endpoint_public_access_cidrs = var.eks_cluster_endpoint_public_access_cidrs
    cluster_endpoint_private_access      = var.eks_cluster_endpoint_private_access
    create_cloudwatch_log_group          = var.eks_create_cloudwatch_log_group
    cluster_ip_family                    = var.eks_cluster_ip_family
    authentication_mode                  = var.eks_authentication_mode
    node_security_group_tags             = var.eks_node_security_group_tags
    tags                                 = var.default_tags
  }

}
