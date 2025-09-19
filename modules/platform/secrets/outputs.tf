output "namespace" {
  description = "External Secrets Operator namespace"
  value       = kubernetes_namespace.external_secrets.metadata[0].name
}

output "release_name" {
  description = "Helm release name"
  value       = helm_release.external_secrets.name
}

output "chart_version" {
  description = "Deployed chart version"
  value       = helm_release.external_secrets.version
}