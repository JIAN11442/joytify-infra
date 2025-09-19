resource "kubernetes_namespace" "ingress_nginx" {
  metadata {
    name = var.namespace
  }
}

resource "helm_release" "nginx_ingress" {
  name       = var.name
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  namespace  = kubernetes_namespace.ingress_nginx.metadata[0].name
  version    = var.ingress_version

  wait          = true
  wait_for_jobs = true
  timeout       = 600

  values = [file("${path.module}/values.yaml")]
}