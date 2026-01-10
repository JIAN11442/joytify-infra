output "argocd_tls_cert" {
  description = "ArgoCD TLS certificate(base64)"
  value       = data.kubernetes_secret.argocd_tls.data["tls.crt"]
  sensitive   = true
}

output "argocd_tls_key" {
  description = "ArgoCD TLS key(base64)"
  value       = data.kubernetes_secret.argocd_tls.data["tls.key"]
  sensitive   = true
}