include "root" {
  path = find_in_parent_folders("root.hcl")
}

locals {
  modules_path   = find_in_parent_folders("modules/")
  envs_prod_path = find_in_parent_folders("environments/prod/")

  source_path       = "${local.modules_path}/networking/ingress/rules"
  cluster_path      = "${local.envs_prod_path}/compute/cluster"
  config_path       = "${local.envs_prod_path}/platform/config"
  cert_issuers_path = "${local.envs_prod_path}/security/certificates/issuers"
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
    # 域名
    api_domain    = "api.127.0.0.1.nip.io"
    web_domain    = "web.127.0.0.1.nip.io"
    argocd_domain = "argocd.127.0.0.1.nip.io"

    # 端口
    api_port = 3000
    web_port = 5173

    # 命名空间
    api_namespace    = "api"
    web_namespace    = "web"
    argocd_namespace = "argocd"

    # 服务名称
    api_service_name = "api-service"
    web_service_name = "web-service"

    # 服务端口
    api_service_port = 3000
    web_service_port = 5173
  }
}

dependency "cert_issuers" {
  config_path = "${local.cert_issuers_path}"

  mock_outputs = {}
}

inputs = {
  # api_ingress_name      = "api-ingress"
  # api_tls_secret_name   = "api-tls-secret"
  # api_ingress_namespace = dependency.config.outputs.api_namespace
  # api_domain            = dependency.config.outputs.api_domain
  # api_service_name      = dependency.config.outputs.api_service_name
  # api_service_port      = dependency.config.outputs.api_service_port

  # web_ingress_name      = "web-ingress"
  # web_tls_secret_name   = "web-tls-secret"
  # web_ingress_namespace = dependency.config.outputs.web_namespace
  # web_domain            = dependency.config.outputs.web_domain
  # web_service_name      = dependency.config.outputs.web_service_name
  # web_service_port      = dependency.config.outputs.web_service_port

  argocd_ingress_name      = "argocd-ingress"
  argocd_tls_secret_name   = "argocd-tls-secret"
  argocd_ingress_namespace = dependency.config.outputs.argocd_namespace
  argocd_domain            = dependency.config.outputs.argocd_domain
  argocd_service_name      = "argocd-server"
  argocd_service_port      = 443

  # letsencrypt clusterIssuer configuration - change to "letsencrypt-prod" for production
  cluster_issuer = "letsencrypt-staging"

  cluster_endpoint       = dependency.cluster.outputs.cluster_endpoint
  cluster_token          = dependency.cluster.outputs.cluster_token
  cluster_ca_certificate = dependency.cluster.outputs.cluster_ca_certificate
}
