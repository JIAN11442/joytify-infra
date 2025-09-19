locals {
  # Parse existing secrets from AWS Secrets Manager
  existing_secrets = jsondecode(data.aws_secretsmanager_secret_version.secrets.secret_string)

  # Domain configuration
  domains = {
    web_domain    = "${var.loadbalancer_ip}.nip.io"
    api_domain    = "api.${var.loadbalancer_ip}.nip.io"
    argocd_domain = "argocd.${var.loadbalancer_ip}.nip.io"
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
    web_namespace    = "web"
    api_namespace    = "api"
    argocd_namespace = "argocd"
  }
}