include "root" {
  path = find_in_parent_folders("root.hcl")
}

locals {
  modules_path   = find_in_parent_folders("modules/")
  envs_prod_path = find_in_parent_folders("environments/prod/")

  source_path  = "${local.modules_path}/security/certificates/backup"
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
    argocd_namespace = "argocd"
    api_namespace    = "api"
    web_namespace    = "web"
  }
}

inputs = {
  aws_secret_name = "JOYTIFY_INFRA_ENVS"

  argocd_tls_secret_name = "argocd-tls-secret"
  argocd_namespace       = dependency.config.outputs.argocd_namespace

  api_tls_secret_name = "api-tls-secret"
  api_namespace       = dependency.config.outputs.api_namespace

  web_tls_secret_name = "web-tls-secret"
  web_namespace       = dependency.config.outputs.web_namespace

  cluster_endpoint       = dependency.cluster.outputs.cluster_endpoint
  cluster_token          = dependency.cluster.outputs.cluster_token
  cluster_ca_certificate = dependency.cluster.outputs.cluster_ca_certificate
}