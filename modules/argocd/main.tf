resource "helm_release" "argocd" {
  name             = "argocd"
  repository       = "https://amat-jfrog.amat.com/artifactory/public-helm-argoproj-remote-repo"
  chart            = "argo-cd"
  namespace        = "argocd"
  create_namespace = true

  values = [
    templatefile("${path.module}/templates/values.yaml.tpl", {
    })
  ]
}


