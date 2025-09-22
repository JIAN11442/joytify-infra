provider "aws" {
  region = "${aws_region}"
}

provider "digitalocean" {
  token = local.do_token
}

provider "kubernetes" {
  host                   = var.cluster_endpoint
  token                  = var.cluster_token
  cluster_ca_certificate = base64decode(var.cluster_ca_certificate)
}

provider "helm" {
  kubernetes {
    host                   = var.cluster_endpoint
    token                  = var.cluster_token
    cluster_ca_certificate = base64decode(var.cluster_ca_certificate)
  }
}

provider "cloudflare" {
  api_token = local.cloudflare_token
}

provider "argocd" {
  server_addr = var.argocd_server_addr
  username    = var.argocd_username
  password    = var.argocd_password
  insecure    = false
  grpc_web    = true
}