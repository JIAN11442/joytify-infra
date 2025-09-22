# 建立 GitOps repository
resource "argocd_repository" "joytify" {
  repo     = var.gitops_repository
  username = var.github_username
  password = var.github_argocd_token
  insecure = var.insecure
}

# 建立 GitOps Applications
resource "argocd_application" "api_app" {
  metadata {
    name      = var.api_app_name
    namespace = var.argocd_namespace # application 資源存放的 namespace
    labels = {
      app = var.api_app_name
    }
  }

  spec {
    project = "default"

    source {
      repo_url        = argocd_repository.joytify.repo # 連結好的 git repo
      path            = "backend" # 哪個目錄下的檔案要被同步
      target_revision = "main" # 哪個 branch 的檔案要被同步
    }

    destination {
      server    = "https://kubernetes.default.svc" # 使用內部 Kubernetes API
      namespace = var.api_app_namespace # 應用程式部署的目標 namespace
    }

    # 同步策略配置
    sync_policy {
      automated {
        prune     = true # PRUNE RESOURCES
        self_heal = true # SELF HEAL
      }

      sync_options = [
        "CreateNamespace=true",             # AUTO-CREATE NAMESPACE
        "PrunePropagationPolicy=foreground" # PRUNE PROPAGATION POLICY
      ]
    }
  }
}

# Web Application
resource "argocd_application" "web_app" {
  metadata {
    name      = var.web_app_name
    namespace = var.argocd_namespace
    labels = {
      app = var.web_app_name
    }
  }

  spec {
    project = "default"

    source {
      repo_url = argocd_repository.joytify.repo
      path = "frontend"
      target_revision = "main"
    }

    destination {
      server = "https://kubernetes.default.svc"
      namespace = var.web_app_namespace
    }

    sync_policy {
      automated {
        prune    = true
        self_heal = true
      }

      sync_options = [
        "CreateNamespace=true",
        "PrunePropagationPolicy=foreground"
      ]
    }
  }
}