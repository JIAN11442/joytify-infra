include "root" {
  path = find_in_parent_folders("root.hcl")
}

locals {
  modules_path   = find_in_parent_folders("modules/")
  envs_prod_path = find_in_parent_folders("environments/prod/")

  source_path       = "${local.modules_path}/platform/argocd/service"
  cluster_path      = "${local.envs_prod_path}/compute/cluster"
  config_path       = "${local.envs_prod_path}/platform/config"
  cert_issuers_path = "${local.envs_prod_path}/security/certificates/issuers"
  secrets_path      = "${local.envs_prod_path}/platform/secrets"
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
    argocd_domain    = "argocd.127.0.0.1.nip.io"
  }
}

dependency "cert_issuers" {
  config_path = "${local.cert_issuers_path}"

  mock_outputs = {}
}

dependency "secrets" {
  config_path = "${local.secrets_path}"

  mock_outputs = {}
}

inputs = {
  argocd_name         = "argocd"
  argocd_namespace    = dependency.config.outputs.argocd_namespace
  argocd_version      = "4.5.2"
  argocd_domain       = dependency.config.outputs.argocd_domain
  argocd_service_port = 443

  cluster_endpoint       = dependency.cluster.outputs.cluster_endpoint
  cluster_token          = dependency.cluster.outputs.cluster_token
  cluster_ca_certificate = dependency.cluster.outputs.cluster_ca_certificate
}