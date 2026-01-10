include "root" {
  path = find_in_parent_folders("root.hcl")
}

locals {
  modules_path   = find_in_parent_folders("modules/")
  envs_prod_path = find_in_parent_folders("environments/prod/")

  source_path  = "${local.modules_path}/security/certificates/manager"
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
    cert_manager_namespace = "cert-manager"
  }
}

inputs = {
  cert_manager_name      = "cert-manager"
  cert_manager_namespace = dependency.config.outputs.cert_manager_namespace
  cert_manager_version   = "v1.18.2"

  cluster_endpoint       = dependency.cluster.outputs.cluster_endpoint
  cluster_token          = dependency.cluster.outputs.cluster_token
  cluster_ca_certificate = dependency.cluster.outputs.cluster_ca_certificate
}