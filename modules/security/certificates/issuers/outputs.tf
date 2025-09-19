output "staging_cluster_issuer_name" {
  description = "Name of the staging ClusterIssuer"
  value       = kubernetes_manifest.letsencrypt_staging_issuer.manifest["metadata"]["name"]
}

output "prod_cluster_issuer_name" {
  description = "Name of the production ClusterIssuer"
  value       = kubernetes_manifest.letsencrypt_prod_issuer.manifest["metadata"]["name"]
}