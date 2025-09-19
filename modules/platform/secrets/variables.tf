variable "external_secrets_name" {
  description = "Name of the external secrets"
  type        = string
}

variable "external_secrets_namespace" {
  description = "Namespace of the external secrets"
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