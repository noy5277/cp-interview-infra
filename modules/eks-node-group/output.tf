output "id" {
  description = "node group id"
  value = aws_eks_node_group.worker-node-group.id
}

output "arn" {
  description = "node group arn"
  value = aws_eks_node_group.worker-node-group.arn
}