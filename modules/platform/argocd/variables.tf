variable "argocd_name" {
  description = "Name for the argocd"
  type        = string
}

variable "argocd_namespace" {
  description = "Namespace for the argocd"
  type        = string
}

variable "argocd_version" {
  description = "Version for the argocd"
  type        = string
}

variable "argocd_domain" {
  description = "Domain for the argocd"
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