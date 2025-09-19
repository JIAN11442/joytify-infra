resource "kubernetes_namespace" "external_secrets" {
    metadata {
      name = var.external_secrets_namespace
    }
}

resource "helm_release" "external_secrets" {
  name = var.external_secrets_name
  repository = "https://charts.external-secrets.io"
  chart = "external-secrets"
  namespace = kubernetes_namespace.external_secrets.metadata[0].name

  wait = true
  wait_for_jobs = true
  timeout = 600

  values = [
    file("${path.module}/values.yaml")
  ]
}