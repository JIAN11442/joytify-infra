
# 讀取 ArgoCD TLS Secret
data "kubernetes_secret" "argocd_tls" {
  metadata {
    name      = var.argocd_tls_secret_name
    namespace = var.argocd_namespace
  }
}


# 讀取 Api TLS Secret
data "kubernetes_secret" "api_tls" {
  metadata {
    name      = var.api_tls_secret_name
    namespace = var.api_namespace
  }
}

# 讀取 Web TLS Secret
data "kubernetes_secret" "web_tls" {
  metadata {
    name      = var.web_tls_secret_name
    namespace = var.web_namespace
  }
}