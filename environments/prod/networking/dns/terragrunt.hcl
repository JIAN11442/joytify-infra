include "root" {
  path = find_in_parent_folders("root.hcl")
}

locals {
  modules_path   = find_in_parent_folders("modules/")
  envs_prod_path = find_in_parent_folders("environments/prod/")

  source_path     = "${local.modules_path}/networking/dns"
  config_path     = "${local.envs_prod_path}/platform/config"
  controller_path = "${local.envs_prod_path}/networking/ingress/controller"
}

terraform {
  source = "${local.source_path}"
}

dependency "config" {
  config_path = "${local.config_path}"

  mock_outputs = {
    cloudflare_zone_id = "your-cloudflare-zone-id"
  }
}

dependency "controller" {
  config_path = "${local.controller_path}"

  mock_outputs = {
    loadbalancer_ip = "188.166.19.xxx"
  }
}

inputs = {
  cloudflare_zone_id = dependency.config.outputs.cloudflare_zone_id
  ip_address         = dependency.controller.outputs.loadbalancer_ip
  ttl                = 1     # Auto TTL
  proxied            = false # Disable Cloudflare proxy
}
