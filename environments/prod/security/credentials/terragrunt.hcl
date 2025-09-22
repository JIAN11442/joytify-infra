include "root" {
  path = find_in_parent_folders("root.hcl")
}

locals {
  modules_path   = find_in_parent_folders("modules/")
  envs_prod_path = find_in_parent_folders("environments/prod/")

  source_path  = "${local.modules_path}/security/credentials"
  cluster_path = "${local.envs_prod_path}/compute/cluster"
  config_path  = "${local.envs_prod_path}/platform/config"
}

terraform {
  source = "${local.source_path}"
}

dependency "cluster" {
  config_path = "${local.cluster_path}"

  mock_outputs = {
    cluster_endpoint       = "https://mock-k8s-api.example.com"
    cluster_token          = "mock-token"
    cluster_ca_certificate = "bW9jay1jYS1jZXJ0Cg=="
  }
}

dependency "config" {
  config_path = "${local.config_path}"

  mock_outputs = {
    web_namespace             = "web"
    api_namespace             = "api"
    aws_credentials_name      = "aws-credentials"
    aws_credential_id_key     = "access-key-id"
    aws_credential_secret_key = "secret-access-key"
    ghcr_secret_name          = "ghcr-secret"
  }
}

inputs = {
  app_namespaces = [dependency.config.outputs.web_namespace, dependency.config.outputs.api_namespace]

  aws_credentials_name      = dependency.config.outputs.aws_credentials_name
  aws_credential_id_key     = dependency.config.outputs.aws_credential_id_key
  aws_credential_secret_key = dependency.config.outputs.aws_credential_secret_key

  ghcr_secret_name = dependency.config.outputs.ghcr_secret_name

  cluster_endpoint       = dependency.cluster.outputs.cluster_endpoint
  cluster_token          = dependency.cluster.outputs.cluster_token
  cluster_ca_certificate = dependency.cluster.outputs.cluster_ca_certificate
}