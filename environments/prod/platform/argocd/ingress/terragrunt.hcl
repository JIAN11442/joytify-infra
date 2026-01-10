include "root" {
  path = find_in_parent_folders("root.hcl")
}

locals {
  modules_path   = find_in_parent_folders("modules/")
  envs_prod_path = find_in_parent_folders("environments/prod/")

  source_path         = "${local.modules_path}/platform/argocd/ingress"
  cluster_path        = "${local.envs_prod_path}/compute/cluster"
  config_path         = "${local.envs_prod_path}/platform/config"
  cert_issuers_path   = "${local.envs_prod_path}/security/certificates/issuers"
  argocd_service_path = "${local.envs_prod_path}/platform/argocd/service"
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

dependency "argocd_service" {
  config_path = "${local.argocd_service_path}"

  mock_outputs = {
    service_port = 443
  }
}

inputs = {
  argocd_ingress_name      = "argocd-ingress"
  argocd_tls_secret_name   = "argocd-tls-secret"
  argocd_ingress_namespace = dependency.config.outputs.argocd_namespace
  argocd_domain            = dependency.config.outputs.argocd_domain
  argocd_service_name      = "argocd-server"
  argocd_service_port      = dependency.argocd_service.outputs.service_port

  # letsencrypt clusterIssuer configuration - change to "letsencrypt-prod" for production
  cluster_issuer = "letsencrypt-prod"

  cluster_endpoint       = dependency.cluster.outputs.cluster_endpoint
  cluster_token          = dependency.cluster.outputs.cluster_token
  cluster_ca_certificate = dependency.cluster.outputs.cluster_ca_certificate
}
