# DOMAINS
output "web_domain" {
  value     = local.domains.web_domain
  sensitive = true
}

output "api_domain" {
  value     = local.domains.api_domain
  sensitive = true
}

output "argocd_domain" {
  value     = local.domains.argocd_domain
  sensitive = true
}


# SERVICES
output "web_service_name" {
  value = local.services.web_service_name
}

output "api_service_name" {
  value = local.services.api_service_name
}

output "web_service_port" {
  value = local.services.web_service_port
}

output "api_service_port" {
  value = local.services.api_service_port
}


# NAMES
output "aws_credentials_name" {
  value = local.names.aws_credentials_name
}

output "ghcr_secret_name" {
  value = local.names.ghcr_secret_name
}


# NAMESPACES
output "web_namespace" {
  value = local.namespaces.web_namespace
}

output "api_namespace" {
  value = local.namespaces.api_namespace
}

output "argocd_namespace" {
  value = local.namespaces.argocd_namespace
}

output "cert_manager_namespace" {
  value = local.namespaces.cert_manager_namespace
}

output "external_secrets_namespace" {
  value = local.namespaces.external_secrets_namespace
}


# KEYS
output "aws_credential_id_key" {
  value = local.keys.aws_credential_id_key
}

output "aws_credential_secret_key" {
  value = local.keys.aws_credential_secret_key
}


# TOKENS
output "argocd_repo_token" {
  value = local.tokens.argocd_repo_token
  sensitive = true
}

# TLS CERTIFICATES
output "argocd_tls_cert" {
  description = "ArgoCD TLS certificate from backup (base64 encoded)"
  value       = local.argocd_tls_cert
  sensitive   = true
}

output "argocd_tls_key" {
  description = "ArgoCD TLS private key from backup (base64 encoded)"
  value       = local.argocd_tls_key
  sensitive   = true
}

# API TLS
output "api_tls_cert" {
  description = "API TLS certificate from backup (base64 encoded)"
  value       = local.api_tls_cert
  sensitive   = true
}

output "api_tls_key" {
  description = "API TLS private key from backup (base64 encoded)"
  value       = local.api_tls_key
  sensitive   = true
}

# Web TLS
output "web_tls_cert" {
  description = "Web TLS certificate from backup (base64 encoded)"
  value       = local.web_tls_cert
  sensitive   = true
}

output "web_tls_key" {
  description = "Web TLS private key from backup (base64 encoded)"
  value       = local.web_tls_key
  sensitive   = true
}

# OTHER
output "certificate_email" {
  value     = local.certificate_email
  sensitive = true
}

output "cloudflare_zone_id" {
  value     = local.cloudflare_zone_id
  sensitive = true
}


