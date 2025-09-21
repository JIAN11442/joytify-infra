include "root" {
  path = find_in_parent_folders("root.hcl")
}

locals {
  modules_path   = find_in_parent_folders("modules/")
  envs_prod_path = find_in_parent_folders("environments/prod/")

  source_path  = "${local.modules_path}/security/certificates/issuers"
  cluster_path = "${local.envs_prod_path}/compute/cluster"
  config_path  = "${local.envs_prod_path}/platform/config"
  manager_path = "${local.envs_prod_path}/security/certificates/manager"
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
    certificate_email = "joytify35@gmail.com"
  }
}

dependency "manager" {
  config_path = "${local.manager_path}"

  mock_outputs = {
    cert_manager_ready = true
  }
}

inputs = {
  cert_manager_ready = dependency.manager.outputs.cert_manager_ready
  cert_manager_email = dependency.config.outputs.certificate_email

  cluster_endpoint       = dependency.cluster.outputs.cluster_endpoint
  cluster_token          = dependency.cluster.outputs.cluster_token
  cluster_ca_certificate = dependency.cluster.outputs.cluster_ca_certificate
}