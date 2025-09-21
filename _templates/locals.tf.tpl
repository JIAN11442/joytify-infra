locals {
  secret_data = jsondecode(data.aws_secretsmanager_secret_version.secrets.secret_string)

  do_token          = local.secret_data["DO_TOKEN"]
}