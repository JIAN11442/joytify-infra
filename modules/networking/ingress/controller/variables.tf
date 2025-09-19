variable "name" {
  description = "Name of the ingress controller"
  type        = string
  default     = "nginx-ingress"
}

variable "namespace" {
  description = "The namespace to deploy the ingress controller"
  type        = string
  default     = "ingress-nginx"
}

variable "ingress_version" {
  description = "Version of the ingress-nginx chart"
  type        = string
  default     = "4.0.6"
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