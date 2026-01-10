# ArgoCD TLS secret
variable "argocd_tls_secret_name" {
  description = "Name of the ArgoCD TLS secret"
  type        = string
}

variable "argocd_namespace" {
  description = "Namespace of the ArgoCD"
  type        = string
}

variable "argocd_tls_cert" {
  description = "ArgoCD TLS certificate(base64 encoded)"
  type        = string
  sensitive   = true
  default     = null
}

variable "argocd_tls_key" {
  description = "ArgoCD TLS private key(base64 encoded)"
  type        = string
  sensitive   = true
  default     = null
}

# API TLS secret
variable "api_tls_secret_name" {
  description = "Name of the API TLS secret"
  type = string
}

variable "api_namespace" {
  description = "Namespace of the API"
  type        = string
}

variable "api_tls_cert" {
  description = "API TLS certificate(base64 encoded)"
  type        = string
  sensitive   = true
  default     = null
}

variable "api_tls_key" {
  description = "API TLS private key(base64 encoded)"
  type        = string
  sensitive   = true
  default     = null
}

# WEB TLS secret
variable "web_tls_secret_name" {
  description = "Name of the WEB TLS secret"
  type = string
}

variable "web_namespace" {
  description = "Namespace of the WEB"
  type        = string
}

variable "web_tls_cert" {
  description = "WEB TLS certificate(base64 encoded)"
  type        = string
  sensitive   = true
  default     = null
}

variable "web_tls_key" {
  description = "WEB TLS private key(base64 encoded)"
  type        = string
  sensitive   = true
  default     = null
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