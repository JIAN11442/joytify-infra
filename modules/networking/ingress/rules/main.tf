resource "kubernetes_ingress_v1" "argocd_ingress" {
  metadata {
    name      = var.argocd_ingress_name
    namespace = var.argocd_ingress_namespace
    annotations = {
      "kubernetes.io/ingress.class"                    = "nginx"
      "cert-manager.io/cluster-issuer"                 = var.cluster_issuer
      "nginx.ingress.kubernetes.io/ssl-redirect"       = "true"
      "nginx.ingress.kubernetes.io/force-ssl-redirect" = "true"
      "nginx.ingress.kubernetes.io/backend-protocol"   = "HTTPS"
    }
  }

  spec {
    tls {
      hosts       = [var.argocd_domain]
      secret_name = var.argocd_tls_secret_name
    }

    rule {
      host = var.argocd_domain
      http {
        path {
          path      = "/"
          path_type = "Prefix"
          backend {
            service {
              name = var.argocd_service_name
              port {
                number = var.argocd_service_port
              }
            }
          }
        }
      }
    }
  }
}
