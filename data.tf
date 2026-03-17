data "aws_eks_cluster" "eks" {
  name = module.eks_cluster.name
  depends_on = [module.eks_node_group]
}

data "aws_eks_cluster_auth" "eks" {
  name = module.eks_cluster.name
  depends_on = [module.eks_node_group]
}