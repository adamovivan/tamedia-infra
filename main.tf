module "vpc" {
  source                  = "./vpc"
  vpc_cidr                = var.vpc_cidr
  subnets_cidrs           = var.subnet_cidrs
  map_public_ip_on_launch = var.map_public_ip_on_launch
  max_subnets             = 20
}

module "security" {
  source          = "./security"
  vpc_id          = module.vpc.vpc_id
  security_groups = var.security_groups
}

module "eks" {
  source                             = "./eks"
  cluster_name                       = var.cluster_name
  node_group_name                    = var.node_group_name
  public_subnets                     = module.vpc.public_subnets
  AmazonEKSClusterPolicy             = module.security.AmazonEKSClusterPolicy
  AmazonEKSVPCResourceController     = module.security.AmazonEKSVPCResourceController
  cluster_role_arn                   = module.security.cluster_role_arn
  node_role_arn                      = module.security.node_role_arn
  AmazonEKSWorkerNodePolicy          = module.security.AmazonEKSWorkerNodePolicy
  AmazonEKS_CNI_Policy               = module.security.AmazonEKS_CNI_Policy
  AmazonEC2ContainerRegistryReadOnly = module.security.AmazonEC2ContainerRegistryReadOnly
  security_group_ids                 = module.security.security_group_id
  sc_desired_size                    = var.sc_desired_size
  sc_max_size                        = var.sc_max_size
  sc_min_size                        = var.sc_min_size
  instance_types                     = var.instance_types
  capacity_type                      = var.capacity_type
}