module "eks_cluster" {
  source                       = "./modules/eks"
  endpoint_public_access       = var.endpoint_public_access
  endpoint_private_access      = var.endpoint_private_access
  vpc_id                       = module.vpc.id
  cluster_name                 = "${var.env}-${var.eks_name}"
  cluster_subnets_ids          = [for subnet in module.subnets : subnet.id]
  kubernetes_resources_ip_cidr = var.kubernetes_resources_ip_cidr
  eks_version                  = var.eks_version
  tags                         = var.tags
}

module "eks_node_group" {
  source         = "./modules/eks-node-group"
  for_each       = var.node_groups
  cluster_name   = module.eks_cluster.name
  eks_version    = var.eks_version
  label          = each.value.label
  subnets_ids    = each.value.subnets_ids
  instance_types = each.value.instance_types
  capacity_type  = each.value.capacity_type
  min_nodes      = each.value.min_nodes
  max_nodes      = each.value.max_nodes
  desired_nodes  = each.value.desired_nodes
  tags           = var.tags
  depends_on = [
    module.eks_cluster
  ]
}

module "addons" {
  source       = "./modules/addons"
  cluster_name = module.eks_cluster.name
  addons       = var.addons
  depends_on   = [module.eks_node_group]
}

module "lbc" {
  source = "./modules/lbc"
  vpc_id = module.vpc.id
  eks_name = module.eks_cluster.name
  depends_on = [module.eks_node_group]
}

module "argocd" {
  source = "./modules/argocd"
  aks_cluster_name = module.eks_cluster.name
}