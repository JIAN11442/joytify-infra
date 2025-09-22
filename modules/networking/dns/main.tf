# Root domain record
resource "cloudflare_dns_record" "root_domain" {
  zone_id = var.cloudflare_zone_id
  name    = "@"
  type    = "A"
  content = var.ip_address
  ttl     = var.ttl
  proxied = var.proxied
}

# API subdomain record
resource "cloudflare_dns_record" "api_subdomain" {
  zone_id = var.cloudflare_zone_id
  name    = "api"
  type    = "A"
  content = var.ip_address
  ttl     = var.ttl
  proxied = var.proxied
}

# ArgoCD subdomain record
resource "cloudflare_dns_record" "argocd_subdomain" {
  zone_id = var.cloudflare_zone_id
  name    = "argocd"
  type    = "A"
  content = var.ip_address
  ttl     = var.ttl
  proxied = var.proxied
}
