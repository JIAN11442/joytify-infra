# Restore ArgoCD TLS secret
resource "kubernetes_secret" "argocd_tls" {
  count = var.argocd_tls_cert != null && var.argocd_tls_key != null ? 1 : 0

  metadata {
    name      = var.argocd_tls_secret_name
    namespace = var.argocd_namespace
  }

  type = "kubernetes.io/tls"

  data = {
    "tls.crt" = var.argocd_tls_cert
    "tls.key" = var.argocd_tls_key
  }

  lifecycle {
    # 如果 cert-manager 更新了證書，照理說會自動更新目前這個 secret
    # 但為了下一次再次 deploy 時，不讓 terraform 因為發現舊 data(aws來的) 跟新 data(cert-manager 更新的)不一致，而強制將新 data 覆蓋為舊 data
    # 所以需要設定 ignore_changes 來避免這種情況，這樣以來始終就會是新 data（萬一 cert-manager 更新了證書）
    ignore_changes = [data]
  }
}

# Restore API TLS secret
resource "kubernetes_secret" "api_tls" {
  count = var.api_tls_cert != null && var.api_tls_key != null ? 1 : 0

  metadata {
    name      = var.api_tls_secret_name
    namespace = var.api_namespace
  }

  type = "kubernetes.io/tls"

  data = {
    "tls.crt" = var.api_tls_cert
    "tls.key" = var.api_tls_key
  }

  lifecycle {
    ignore_changes = [data]
  }
}

# Restore Web TLS secret
resource "kubernetes_secret" "web_tls" {
  count = var.web_tls_cert != null && var.web_tls_key != null ? 1 : 0

  metadata {
    name      = var.web_tls_secret_name
    namespace = var.web_namespace
  }

  type = "kubernetes.io/tls"

  data = {
    "tls.crt" = var.web_tls_cert
    "tls.key" = var.web_tls_key
  }

  lifecycle {
    ignore_changes = [data]
  }
}