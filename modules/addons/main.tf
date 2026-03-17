resource "aws_eks_addon" "addons" {
  count = length(var.addons)
  cluster_name = var.cluster_name
  addon_name   = var.addons[count.index]
}
