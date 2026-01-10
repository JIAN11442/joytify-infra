locals {
  # Parse existing secrets from AWS Secrets Manager
  existing_secrets = jsondecode(data.aws_secretsmanager_secret_version.secrets.secret_string)

  # Domain configuration
  domains = {
    web_domain    = local.existing_secrets["WEB_DOMAIN"]
    api_domain    = local.existing_secrets["API_DOMAIN"]
    argocd_domain = local.existing_secrets["ARGOCD_DOMAIN"]
  }

  # Service configuration
  services = {
    web_service_name = "web-service"
    api_service_name = "api-service"
    web_service_port = 5173
    api_service_port = 4004
  }

  # Key configuration
  keys = {
    aws_credential_id_key    = "access-key-id"
    aws_credential_secret_key = "secret-access-key"
  }

  # Name configuration
  names = {
    aws_credentials_name = "aws-credentials"
    ghcr_secret_name = "ghcr-secret"
  }

  # Namespace configuration
  namespaces = {
    # Application namespaces
    web_namespace    = "web"
    api_namespace    = "api"
    argocd_namespace = "argocd"

    # System namespaces
    cert_manager_namespace     = "cert-manager"
    external_secrets_namespace = "external-secrets"
  }

  # Token configuration
  tokens = {
    argocd_repo_token = local.existing_secrets["ARGOCD_REPO_TOKEN"]
  }

  # TLS Certificates (if exists)
  argocd_tls_cert = try(local.existing_secrets["ARGOCD_TLS_CERT"], null)
  argocd_tls_key  = try(local.existing_secrets["ARGOCD_TLS_KEY"], null)

  api_tls_cert = try(local.existing_secrets["API_TLS_CERT"], null)
  api_tls_key  = try(local.existing_secrets["API_TLS_KEY"], null)

  web_tls_cert = try(local.existing_secrets["WEB_TLS_CERT"], null)
  web_tls_key  = try(local.existing_secrets["WEB_TLS_KEY"], null)

  # Other configuration
  certificate_email = local.existing_secrets["CERTIFICATE_EMAIL"]
  cloudflare_zone_id = local.existing_secrets["CLOUDFLARE_ZONE_ID"]
}