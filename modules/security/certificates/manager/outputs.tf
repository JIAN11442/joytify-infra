output "cert_manager_namespace" {
  description = "Namespace where cert-manager is installed"
  value       = helm_release.cert_manager.namespace
}

output "cert_manager_ready" {
  description = "Flag indicating if cert-manager is ready"
  value       = true
  depends_on  = [null_resource.wait_for_crds]
}