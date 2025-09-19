data "kubernetes_service" "nginx_ingress_controller" {
  metadata {
    name      = "${helm_release.nginx_ingress.name}-ingress-nginx-controller"
    namespace = kubernetes_namespace.ingress_nginx.metadata[0].name
  }

  depends_on = [helm_release.nginx_ingress]

}