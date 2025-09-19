output "argocd_login_info" {
  description = "ArgoCD login information"
  value = {
    domain           = var.argocd_domain
    url              = "https://${var.argocd_domain}"
    namespace        = helm_release.argocd.namespace
    username         = "admin"
    password_command = "kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath='{.data.password}' | base64 -d && echo"
    note             = "Please change password after first login"
  }
}
