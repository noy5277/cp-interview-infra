output "cluster_name" {
  description = "The name of the eks cluster"
  value = module.eks_cluster.name
}

output "region" {
  description = "region where eks cluster located"
  value = var.aws_region
}

output "cluster_public_url" {
  value = module.eks_cluster.endpoint
  description = "The cluster public url"
}
