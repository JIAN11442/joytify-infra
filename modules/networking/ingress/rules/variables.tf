variable "cluster_issuer" {
  description = "ClusterIssuer to use for TLS certificates (letsencrypt-staging or letsencrypt-prod)"
  type        = string
  default     = "letsencrypt-staging"
  validation {
    condition     = contains(["letsencrypt-staging", "letsencrypt-prod"], var.cluster_issuer)
    error_message = "Cluster issuer must be either 'letsencrypt-staging' or 'letsencrypt-prod'."
  }
}


# ARGOCD
variable "argocd_ingress_name" {
  description = "Name for the argocd ingress"
  type        = string
}

variable "argocd_ingress_namespace" {
  description = "Namespace for the argocd"
  type        = string
  default     = "argocd"
}

variable "argocd_tls_secret_name" {
  description = "Name for the argocd tls secret"
  type        = string
}

variable "argocd_service_name" {
  description = "Name for the argocd service"
  type        = string
}

variable "argocd_domain" {
  description = "Domain for the argocd"
  type        = string
}

variable "argocd_service_port" {
  description = "Port for the argocd service"
  type        = number
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
