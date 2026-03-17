resource "helm_release" "nginx" {
  name = "nginx"
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart = "ingress-nginx"
  namespace = "ingress"
  create_namespace = true
  verify = "4.10.1"

  values = [file("${path.module}/values/nginx-ingress.yaml")]
  depends_on = [  ]
}