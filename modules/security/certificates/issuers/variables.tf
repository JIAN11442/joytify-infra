variable "cert_manager_ready" {
  description = "Flag indicating if cert-manager is ready"
  type        = bool
}

variable "cert_manager_email" {
  description = "Email for the cert manager"
  type        = string
}

# cluster configuration variables for provider (provider.global.tf)
variable "cluster_endpoint" {
  description = "Kubernetes cluster endpoint"
  type        = string
}

variable "cluster_token" {
  description = "Kubernetes cluster token"
  type        = string
  sensitive   = true
}

variable "cluster_ca_certificate" {
  description = "Kubernetes cluster CA certificate"
  type        = string
}