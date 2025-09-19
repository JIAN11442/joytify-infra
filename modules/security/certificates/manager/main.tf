resource "kubernetes_namespace" "cert_manager" {
  metadata {
    name = var.cert_manager_namespace
  }
}

resource "helm_release" "cert_manager" {
  name       = var.cert_manager_name
  repository = "https://charts.jetstack.io"
  chart      = "cert-manager"
  namespace  = kubernetes_namespace.cert_manager.metadata[0].name
  version    = var.cert_manager_version

  set {
    name  = "crds.enabled"
    value = "true"
  }


  # destroy 後, 要（true: 保留, false: 刪除）CRDs
  set {
    name  = "crds.keep"
    value = "false"
  }

  wait          = true
  wait_for_jobs = true
  timeout       = 600
}

# 等待 CRDs 安裝完成
resource "null_resource" "wait_for_crds" {
  depends_on = [helm_release.cert_manager]

  provisioner "local-exec" {
    command = <<EOT
      set -e
      echo "Waiting for cert-manager CRDs..."
      for i in {1..30}; do
        if kubectl get crd clusterissuers.cert-manager.io >/dev/null 2>&1; then
          echo "✅ cert-manager CRDs ready"
          exit 0
        fi
        echo "⏳ Still waiting..."
        sleep 5
      done
      echo "❌ Timeout waiting for cert-manager CRDs"
      exit 1
    EOT
  }
}