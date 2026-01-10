# 更新 AWS Secrets Manager 中的 secrets
resource "aws_secretsmanager_secret_version" "update_secrets" {
  secret_id = var.aws_secret_name
  secret_string = jsonencode(merge(local.existing_secrets, {

    # pod envs
    API_PORT       = local.services.api_service_port
    WEB_PORT       = local.services.web_service_port
    AWS_CREDENTIALS_NAME = local.names.aws_credentials_name
    GHCR_SECRET_NAME = local.names.ghcr_secret_name
    AWS_CREDENTIAL_ID_KEY = local.keys.aws_credential_id_key
    AWS_CREDENTIAL_SECRET_KEY = local.keys.aws_credential_secret_key

    # helm values
    WEB_SERVICE_NAME = local.services.web_service_name
    API_SERVICE_NAME = local.services.api_service_name
    WEB_SERVICE_PORT = local.services.web_service_port
    API_SERVICE_PORT = local.services.api_service_port

  }))
}