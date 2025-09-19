# 經過完整測試的穩定版本組合 (Terraform 1.5.7 + Kubernetes 1.33.1)
# 固定版本確保 DevOps 環境穩定性和可預測性

terraform {
  required_version = "~> 1.5.7"
  
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "= 5.49.0"
    }
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "= 2.67.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "= 2.23.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "= 2.17.0"
    }
  }
}