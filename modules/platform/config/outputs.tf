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


# KEYS
output "aws_credential_id_key" {
  value = local.keys.aws_credential_id_key
}

output "aws_credential_secret_key" {
  value = local.keys.aws_credential_secret_key
}

# OTHER
output "certificate_email" {
  value     = local.certificate_email
  sensitive = true
}