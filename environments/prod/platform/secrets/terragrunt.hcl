include "root" {
  path = find_in_parent_folders("root.hcl")
}

locals {
  modules_path   = find_in_parent_folders("modules/")
  envs_prod_path = find_in_parent_folders("environments/prod/")

  source_path  = "${local.modules_path}/platform/secrets"
  cluster_path = "${local.envs_prod_path}/compute/cluster"
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

inputs = {
  external_secrets_name      = "external-secrets"
  external_secrets_namespace = "external-secrets"

  cluster_endpoint       = dependency.cluster.outputs.cluster_endpoint
  cluster_token          = dependency.cluster.outputs.cluster_token
  cluster_ca_certificate = dependency.cluster.outputs.cluster_ca_certificate
}