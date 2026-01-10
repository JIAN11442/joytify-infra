# GITOPS REPOSITORY
variable "gitops_repository" {
  description = "Gitops repository"
  type        = string
}

variable "github_username" {
  description = "GitHub username"
  type        = string
}

variable "github_argocd_token" {
  description = "GitHub ArgoCD token"
  type        = string
}

# 如果是 false，代表要驗證 Git repo 的 SSL/TLS 憑證；true 則不驗證(跳過驗證)
variable "insecure" {
  description = "Insecure repository certificate"
  type        = bool
  default     = false
}


# GITOPS APPLICATIONS
variable "api_app_name" {
  description = "API application name"
  type        = string
}

variable "api_app_namespace" {
  description = "API application namespace"
  type        = string
}

variable "web_app_name" {
  description = "Frontend application name"
  type        = string
}

variable "web_app_namespace" {
  description = "Frontend application namespace"
  type        = string
}

variable "argocd_namespace" {
  description = "ArgoCD namespace"
  type        = string
}


# ARGOCD PROVIDER CONFIGURATION
variable "argocd_server_addr" {
  description = "ArgoCD server address"
  type        = string
}

variable "argocd_username" {
  description = "ArgoCD username"
  type        = string
}

variable "argocd_password" {
  description = "ArgoCD password"
  type        = string
  sensitive   = true
}