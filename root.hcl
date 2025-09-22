# 全局配置
locals {
  # 項目資訊
  project_name    = "joytify-infra"
  project_owner   = "jian11442"
  github_username = "JIAN11442"
  cluster_name    = "${local.project_name}-doks-prod-cluster"

  # 雲服務商配置
  aws_region      = "ap-northeast-1"
  aws_secret_name = "JOYTIFY_INFRA_ENVS"

  # 標籤配置
  common_tags = {
    Project   = local.project_name
    Owner     = local.project_owner
    ManagedBy = "Terragrunt"
  }
}


# 遠端狀態配置(AWS S3)
remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    bucket         = "${local.project_name}-tfstate-bucket"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = local.aws_region
    encrypt        = true
    dynamodb_table = "${local.project_name}-tfstate-lock-table"
  }
}

# 生成全域配置文件
generate "providers" {
  path      = "providers.global.tf"
  if_exists = "overwrite_terragrunt"
  contents = templatefile("${get_parent_terragrunt_dir()}/_templates/providers.tf.tpl", {
    aws_region = local.aws_region
  })
}

generate "datasources" {
  path      = "datasources.global.tf"
  if_exists = "overwrite_terragrunt"
  contents = templatefile("${get_parent_terragrunt_dir()}/_templates/datasources.tf.tpl", {
    aws_secret_name = local.aws_secret_name
  })
}

generate "versions" {
  path      = "versions.global.tf"
  if_exists = "overwrite_terragrunt"
  contents  = templatefile("${get_parent_terragrunt_dir()}/_templates/versions.tf.tpl", {})
}

generate "locals" {
  path      = "locals.global.tf"
  if_exists = "overwrite_terragrunt"
  contents  = templatefile("${get_parent_terragrunt_dir()}/_templates/locals.tf.tpl", {})
}


# 全局變數配置
inputs = {
  cluster_name    = local.cluster_name
  aws_region      = local.aws_region
  aws_secret_name = local.aws_secret_name
  github_username = local.github_username
}