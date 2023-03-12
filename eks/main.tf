resource "aws_eks_cluster" "eks_cluster" {
  name     = var.cluster_name
  role_arn = var.cluster_role_arn

  vpc_config {
    subnet_ids             = var.public_subnets
    security_group_ids     = var.security_group_ids
  }

  depends_on = [
    var.AmazonEKSClusterPolicy,
    var.AmazonEKSVPCResourceController,
  ]
}

resource "aws_eks_node_group" "eks_node_group" {
  cluster_name    = aws_eks_cluster.eks_cluster.name
  node_group_name = var.node_group_name
  node_role_arn   = var.node_role_arn
  subnet_ids      = var.public_subnets
  instance_types  = var.instance_types
  capacity_type   = var.capacity_type

  scaling_config {
    desired_size = var.sc_desired_size
    max_size     = var.sc_max_size
    min_size     = var.sc_min_size
  }

  depends_on = [
    var.AmazonEKSWorkerNodePolicy,
    var.AmazonEKS_CNI_Policy,
    var.AmazonEC2ContainerRegistryReadOnly,
  ]
}