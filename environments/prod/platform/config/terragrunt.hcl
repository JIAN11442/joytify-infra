include "root" {
  path = find_in_parent_folders("root.hcl")
}

locals {
  modules_path   = find_in_parent_folders("modules/")
  envs_prod_path = find_in_parent_folders("environments/prod/")

  source_path     = "${local.modules_path}/platform/config"
  controller_path = "${local.envs_prod_path}/networking/ingress/controller"
}

terraform {
  source = "${local.source_path}"
}

dependency "controller" {
  config_path = "${local.controller_path}"

  mock_outputs = {
    loadbalancer_ip = "127.0.0.1"
  }
}

inputs = {
  loadbalancer_ip = dependency.controller.outputs.loadbalancer_ip
}