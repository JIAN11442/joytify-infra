output "cluster_id" {
  description = "The ID of the Kubernetes cluster"
  value       = digitalocean_kubernetes_cluster.main.id
}

output "cluster_urn" {
  description = "The uniform resource name (URN) of the Kubernetes cluster"
  value       = digitalocean_kubernetes_cluster.main.urn
}

output "cluster_endpoint" {
  description = "The base URL of the API server on the Kubernetes master node"
  value       = digitalocean_kubernetes_cluster.main.endpoint
}

output "cluster_ca_certificate" {
  description = "The base64 encoded public certificate for the cluster's certificate authority"
  value       = digitalocean_kubernetes_cluster.main.kube_config[0].cluster_ca_certificate
  sensitive   = true
}

output "cluster_token" {
  description = "The DigitalOcean Kubernetes cluster token"
  value       = digitalocean_kubernetes_cluster.main.kube_config[0].token
  sensitive   = true
}

output "kubeconfig_raw" {
  description = "A representation of the Kubernetes cluster's kubeconfig"
  value       = digitalocean_kubernetes_cluster.main.kube_config[0].raw_config
  sensitive   = true
}

output "cluster_context_name" {
  description = "The kubectl context name for this cluster"
  value       = "do-${var.do_region}-${var.cluster_name}"
}