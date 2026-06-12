locals {
  # 平文で問題ない設定値は Variables として登録する。
  variables = {
    GOOGLE_CLOUD_PROJECT_ID   = var.google_cloud_project_id
    GOOGLE_CLOUD_REGION       = var.google_cloud_region
    GOOGLE_CLOUD_PROJECT_NAME = var.google_cloud_project_name
  }
}

resource "github_actions_variable" "this" {
  for_each = local.variables

  repository    = var.github_repository
  variable_name = each.key
  value         = each.value
}

resource "github_actions_secret" "billing_account" {
  repository      = var.github_repository
  secret_name     = "GOOGLE_CLOUD_BILLING_ACCOUNT"
  plaintext_value = var.google_cloud_billing_account
}

# cloud-run-service の sensitive な tfvars をそのまま Secret 化する。
# 二重管理を避けるため実ファイルを参照する（gitignore 済み・ローカルにのみ存在）。
resource "github_actions_secret" "tfvars_cloud_run_service" {
  repository      = var.github_repository
  secret_name     = "TFVARS_CLOUD_RUN_SERVICE"
  plaintext_value = file("${path.module}/../../google/cloud-run-service/terraform.tfvars")
}

# apply ワークフローが参照する production environment。
# 必須レビュアーを設定し、apply 前に手動承認を強制する。
resource "github_repository_environment" "production" {
  repository  = var.github_repository
  environment = "production"

  reviewers {
    users = var.production_reviewer_ids
  }

  deployment_branch_policy {
    protected_branches     = true
    custom_branch_policies = false
  }
}
