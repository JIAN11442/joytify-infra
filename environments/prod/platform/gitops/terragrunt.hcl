include "root" {
  path = find_in_parent_folders("root.hcl")
}

locals {
  modules_path   = find_in_parent_folders("modules/")
  envs_prod_path = find_in_parent_folders("environments/prod/")

  source_path = "${local.modules_path}/platform/gitops"
  config_path = "${local.envs_prod_path}/platform/config"
  argocd_path = "${local.envs_prod_path}/platform/argocd"
}

terraform {
  source = "${local.source_path}"
}

dependency "config" {
  config_path = "${local.config_path}"
}

dependency "argocd" {
  config_path = "${local.argocd_path}"

  mock_outputs = {
    server_addr    = "https://mock-argocd.example.com"
    admin_username = "admin"
    admin_password = "password"
  }
}

inputs = {
  # repository
  gitops_repository   = "https://github.com/JIAN11442/joytify-helm"
  github_argocd_token = dependency.config.outputs.argocd_repo_token
  insecure            = false

  # applications
  api_app_name      = "joytify-api"
  api_app_namespace = dependency.config.outputs.api_namespace
  web_app_name      = "joytify-web"
  web_app_namespace = dependency.config.outputs.web_namespace
  argocd_namespace  = dependency.config.outputs.argocd_namespace

  # argocd provider configuration
  argocd_server_addr = dependency.argocd.outputs.server_addr
  argocd_username    = dependency.argocd.outputs.admin_username
  argocd_password    = dependency.argocd.outputs.admin_password
}