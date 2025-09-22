output "dns_records" {
  description = "Information about the created/updated DNS records"
  value = {
    root_domain = {
      id      = cloudflare_dns_record.root_domain.id
      name    = cloudflare_dns_record.root_domain.name
      content = cloudflare_dns_record.root_domain.content
    }
    api_subdomain = {
      id      = cloudflare_dns_record.api_subdomain.id
      name    = cloudflare_dns_record.api_subdomain.name
      content = cloudflare_dns_record.api_subdomain.content
    }
    argocd_subdomain = {
      id      = cloudflare_dns_record.argocd_subdomain.id
      name    = cloudflare_dns_record.argocd_subdomain.name
      content = cloudflare_dns_record.argocd_subdomain.content
    }
  }
}
