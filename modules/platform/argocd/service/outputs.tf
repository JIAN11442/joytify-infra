output "namespace" {
  description = "ArgoCD namespace"
  value       = helm_release.argocd.namespace
}

output "domain" {
  description = "ArgoCD domain"
  value       = var.argocd_domain
}

output "service_port" {
  description = "ArgoCD service port"
  value       = var.argocd_service_port
}

output "server_addr" {
  description = "ArgoCD server address"
  value       = "${var.argocd_domain}:${var.argocd_service_port}"
}

output "admin_username" {
  description = "ArgoCD admin username"
  value       = "admin"
}

output "admin_password" {
  description = "ArgoCD admin password (from Kubernetes secret)"
  value       = data.kubernetes_secret.argocd_admin_password.data["password"]
  sensitive   = true
}

output "password_command" {
  description = "Command to retrieve ArgoCD admin password"
  value       = "kubectl -n ${helm_release.argocd.namespace} get secret argocd-initial-admin-secret -o jsonpath='{.data.password}' | base64 -d"
}
