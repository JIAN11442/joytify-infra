include "root" {
  path = find_in_parent_folders("root.hcl")
}

locals {
  modules_path   = find_in_parent_folders("modules/")
  envs_prod_path = find_in_parent_folders("environments/prod/")

  source_path = "${local.modules_path}/platform/config"
}

terraform {
  source = "${local.source_path}"
}

inputs = {}