variable "cert_manager_name" {
  description = "Name of the cert manager"
  type        = string
}

variable "cert_manager_namespace" {
  description = "Namespace of the cert manager"
  type        = string
}

variable "cert_manager_version" {
  description = "Version of the cert manager"
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