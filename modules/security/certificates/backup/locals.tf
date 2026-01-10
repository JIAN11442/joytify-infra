locals {
  existing_secrets = jsondecode(data.aws_secretsmanager_secret_version.secrets.secret_string)
}