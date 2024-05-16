module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.10"

  cluster_name                         = local.eks.cluster_name
  cluster_version                      = local.eks.cluster_version
  cluster_endpoint_private_access      = local.eks.cluster_endpoint_private_access
  cluster_endpoint_public_access       = local.eks.cluster_endpoint_public_access
  cluster_endpoint_public_access_cidrs = local.eks.cluster_endpoint_public_access_cidrs
  create_cloudwatch_log_group          = local.eks.create_cloudwatch_log_group

  enable_cluster_creator_admin_permissions = true

  cluster_addons = {
    kube-proxy = {
      most_recent = true
    }
  }

  vpc_id                   = module.vpc.vpc_id
  subnet_ids               = module.vpc.private_subnets
  control_plane_subnet_ids = module.vpc.private_subnets

  cluster_ip_family   = local.eks.cluster_ip_family
  authentication_mode = local.eks.authentication_mode

  # eks_managed_node_groups = {
  #   mng-grp = {
  #     min_size     = 1
  #     max_size     = 10
  #     desired_size = 1

  #     instance_types = ["t3.small"]
  #     capacity_type  = "SPOT"
  #   }
  # }

  tags = local.eks.tags
}