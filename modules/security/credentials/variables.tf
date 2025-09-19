# NAMESPACES
variable "app_namespaces" {
  description = "List of application namespaces that need GHCR secret"
  type        = list(string)
  default     = ["web", "api"]
}


# AWS CREDENTIALS
variable "aws_credentials_name" {
  description = "AWS Credentials Name"
  type        = string
}

variable "aws_credential_id_key" {
  description = "AWS Credential ID Key"
  type        = string
}

variable "aws_credential_secret_key" {
  description = "AWS Credential Secret Key"
  type        = string
}


# GHCR SECRET
variable "ghcr_secret_name" {
  description = "GHCR Secret Name"
  type        = string
}

variable "github_username" {
  description = "GitHub username for GHCR authentication"
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

