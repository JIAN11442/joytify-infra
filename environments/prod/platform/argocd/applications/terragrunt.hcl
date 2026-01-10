include "root" {
  path = find_in_parent_folders("root.hcl")
}

locals {
  modules_path   = find_in_parent_folders("modules/")
  envs_prod_path = find_in_parent_folders("environments/prod/")

  source_path         = "${local.modules_path}/platform/argocd/applications"
  config_path         = "${local.envs_prod_path}/platform/config"
  argocd_service_path = "${local.envs_prod_path}/platform/argocd/service"
  argocd_ingress_path = "${local.envs_prod_path}/platform/argocd/ingress"
}

terraform {
  source = "${local.source_path}"
}

dependency "config" {
  config_path = "${local.config_path}"

  mock_outputs = {
    argocd_repo_token = "mock-token"
    api_namespace     = "mock-api-ns"
    web_namespace     = "mock-web-ns"
    argocd_namespace  = "mock-argocd-ns"
  }
}

dependency "argocd_service" {
  config_path = "${local.argocd_service_path}"

  mock_outputs = {
    server_addr    = "https://mock-argocd.example.com"
    admin_username = "admin"
    admin_password = "password"
  }
}

dependency "argocd_ingress" {
  config_path = "${local.argocd_ingress_path}"

  mock_outputs = {}
}

inputs = {
  # repository
  gitops_repository   = "https://github.com/JIAN11442/joytify-helm"
  github_argocd_token = dependency.config.outputs.argocd_repo_token
  insecure            = false
  # github_username is from root.hcl global inputs

  # applications
  api_app_name      = "joytify-api"
  api_app_namespace = dependency.config.outputs.api_namespace
  web_app_name      = "joytify-web"
  web_app_namespace = dependency.config.outputs.web_namespace
  argocd_namespace  = dependency.config.outputs.argocd_namespace

  # argocd provider configuration
  argocd_server_addr = dependency.argocd_service.outputs.server_addr
  argocd_username    = dependency.argocd_service.outputs.admin_username
  argocd_password    = dependency.argocd_service.outputs.admin_password
}