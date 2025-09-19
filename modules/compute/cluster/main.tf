resource "digitalocean_kubernetes_cluster" "main" {
  name    = var.cluster_name
  region  = var.do_region
  version = var.kubernetes_version

  node_pool {
    name       = var.node_pool_name
    size       = var.node_size
    node_count = var.node_count
    auto_scale = var.auto_scale
    min_nodes  = var.min_nodes
    max_nodes  = var.max_nodes
  }

  auto_upgrade  = var.auto_upgrade
  surge_upgrade = var.surge_upgrade
}