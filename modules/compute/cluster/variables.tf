variable "cluster_name" {
  description = "Kubernetes cluster name"
  type        = string
}

variable "do_region" {
  description = "DigitalOcean region"
  type        = string
  default     = "sgp1"
}

variable "kubernetes_version" {
  description = "Kubernetes version"
  type        = string
  default     = "1.33.1-do.5"
}

variable "node_pool_name" {
  description = "Node pool name"
  type        = string
  default     = "worker-pool"
}

variable "node_size" {
  description = "Node size"
  type        = string
  default     = "s-1vcpu-2gb"
}

variable "node_count" {
  description = "Initial node count"
  type        = number
  default     = 1
}

variable "auto_scale" {
  description = "Enable auto scaling"
  type        = bool
  default     = false
}

variable "min_nodes" {
  description = "Minimum nodes when auto scaling"
  type        = number
  default     = 1
}

variable "max_nodes" {
  description = "Maximum nodes when auto scaling"
  type        = number
  default     = 2
}

variable "auto_upgrade" {
  description = "Enable automatic cluster upgrades"
  type        = bool
  default     = false
}

variable "surge_upgrade" {
  description = "Enable surge upgrades"
  type        = bool
  default     = false
}

variable "aws_region" {
  description = "AWS region for provider"
  type        = string
  default     = "ap-northeast-1"
}