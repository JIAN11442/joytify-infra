variable "cloudflare_zone_id" {
  description = "Cloudflare Zone ID for joytify.org"
  type        = string
}

variable "ip_address" {
  description = "IP address to point all DNS records to"
  type        = string
}

variable "ttl" {
  description = "TTL for DNS records"
  type        = number
  default     = 1 # Auto TTL
}

variable "proxied" {
  description = "Whether to enable Cloudflare proxy"
  type        = bool
  default     = true
}
