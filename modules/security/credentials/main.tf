# Namespaces (api, web)
resource "kubernetes_namespace" "app_namespaces" {
  for_each = toset(var.app_namespaces)
  
  metadata {
    name = each.value
  }
}

resource "kubernetes_secret" "aws_credentials" {
  metadata {
    name      = "aws-credentials"
    namespace = kubernetes_namespace.app_namespaces["api"].metadata[0].name
  }

  type = "Opaque"

  data = {
    "${var.aws_credential_id_key}"    = local.secret_data["AWS_ACCESS_KEY_ID"]
    "${var.aws_credential_secret_key}" = local.secret_data["AWS_SECRET_ACCESS_KEY"]
  }
  
  depends_on = [kubernetes_namespace.app_namespaces]
}

resource "kubernetes_secret" "ghcr_secret" {
  for_each = toset(var.app_namespaces)
  
  metadata {
    name      = var.ghcr_secret_name
    namespace = each.value
  }

  type = "kubernetes.io/dockerconfigjson"
  
  data = {
    ".dockerconfigjson" = jsonencode({
      auths = {
        "ghcr.io" = {
          username = var.github_username
          password = local.secret_data["GHCR_TOKEN"]
          auth     = base64encode("${var.github_username}:${local.secret_data["GHCR_TOKEN"]}")
        }
      }
    })
  }
  
  depends_on = [kubernetes_namespace.app_namespaces]
}
  

