data "aws_secretsmanager_secret" "secrets" {
  name = "${aws_secret_name}"
}

data "aws_secretsmanager_secret_version" "secrets" {
  secret_id = data.aws_secretsmanager_secret.secrets.id
}