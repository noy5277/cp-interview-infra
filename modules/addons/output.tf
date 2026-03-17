output "id" {
  value = [for addon in aws_eks_addon.addons : addon.id]
}