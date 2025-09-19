output "namespace_name" {
  description = "Name of the ingress-nginx namespace"
  value       = kubernetes_namespace.ingress_nginx.metadata[0].name
}

output "loadbalancer_ip" {
  description = "LoadBalancer IP of the ingress controller"
  value       = data.kubernetes_service.nginx_ingress_controller.status[0].load_balancer[0].ingress[0].ip
}

output "loadbalancer_ip_command" {
  description = "Command to get LoadBalancer IP for DNS setup"
  value       = "kubectl get svc -n ${kubernetes_namespace.ingress_nginx.metadata[0].name} ${helm_release.nginx_ingress.name}-ingress-nginx-controller -o jsonpath='{.status.loadBalancer.ingress[0].ip}'"
}
