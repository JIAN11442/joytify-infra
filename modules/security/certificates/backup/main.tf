resource "aws_secretsmanager_secret_version" "update_tls_secret" {
  secret_id = var.aws_secret_name
  secret_string = jsonencode(merge(local.existing_secrets, {
    # ArgoCD TLS
    ARGOCD_TLS_CERT = data.kubernetes_secret.argocd_tls.data["tls.crt"]
    ARGOCD_TLS_KEY  = data.kubernetes_secret.argocd_tls.data["tls.key"]

    # API TLS
    API_TLS_CERT = data.kubernetes_secret.api_tls.data["tls.crt"]
    API_TLS_KEY  = data.kubernetes_secret.api_tls.data["tls.key"]

    # Web TLS
    WEB_TLS_CERT = data.kubernetes_secret.web_tls.data["tls.crt"]
    WEB_TLS_KEY  = data.kubernetes_secret.web_tls.data["tls.key"]
  }))
}