resource "kubernetes_namespace" "argocd" {
  metadata {
    name = var.argocd_namespace
  }
}

resource "helm_release" "argocd" {
  name       = var.argocd_name
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = var.argocd_version
  namespace  = kubernetes_namespace.argocd.metadata[0].name

  wait = true
  wait_for_jobs = true
  timeout = 600

  values = [
    templatefile("${path.module}/values.yaml", {
      argocd_domain = var.argocd_domain
    })
  ]
}
