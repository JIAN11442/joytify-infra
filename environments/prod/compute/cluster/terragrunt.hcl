# 引用根配置
include "root" {
  path = find_in_parent_folders("root.hcl")
}

locals {
  modules_path = find_in_parent_folders("modules/")
  source_path  = "${local.modules_path}/compute/cluster"
}

# 指定使用的 Terraform module
terraform {
  source = "${local.source_path}"
}

# 服務特定配置
inputs = {
  # do_token 已經透過全域 provider 定義了
  # cluster_name 會自動從 root.hcl 中引用（因為有在 inputs 中定義）
  do_region          = "sgp1"
  kubernetes_version = "1.33.6-do.1"
  node_pool_name     = "worker-pool"
  node_size          = "s-2vcpu-2gb"
  node_count         = 1
  min_nodes          = 1
  max_nodes          = 2

  # 啟用自動升級
  auto_upgrade = true
  # 啟用 surge 升級 (不停機升級，類似於 Kubernetes 的 Rolling Update)
  surge_upgrade = true
}