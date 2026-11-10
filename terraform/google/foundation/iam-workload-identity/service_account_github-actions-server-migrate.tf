# fun-dotto/server の Atlas マイグレーション用 SA。
# Cloud SQL Auth Proxy (--auto-iam-authn) 経由で IAM 認証接続する。
# DB 側のユーザーとロールは terraform/google/foundation/cloud-sql で管理する。

locals {
  # 適用を許可する GitHub Environment。prd は承認必須かつ保護ブランチのみ (terraform/github/fun-dotto/repository-server.tf)
  server_migrate_apply_environments = toset(["dev", "stg", "prd"])

  server_migrate_roles = toset([
    "roles/cloudsql.client",       # Cloud SQL Auth Proxy での接続
    "roles/cloudsql.instanceUser", # IAM 認証でのログイン
  ])
}

# dry-run 用 (読み取り専用): pull_request / merge_group で使う
resource "google_service_account" "github_actions_server_migrate_dry_run" {
  account_id   = "gha-server-migrate-dry-run"
  display_name = "GitHub Actions (server migrate dry-run)"
  description  = "fun-dotto/server の Atlas マイグレーション dry-run 専用 SA (DB 読み取りのみ)"
}

# 適用用 (DDL 権限あり): main への push と workflow_dispatch で使う
resource "google_service_account" "github_actions_server_migrate_apply" {
  account_id   = "gha-server-migrate-apply"
  display_name = "GitHub Actions (server migrate apply)"
  description  = "fun-dotto/server の Atlas マイグレーション適用専用 SA (dotto_admin)"
}

resource "google_project_iam_member" "github_actions_server_migrate_dry_run" {
  for_each = local.server_migrate_roles

  project = var.google_cloud_project_id
  role    = each.value
  member  = "serviceAccount:${google_service_account.github_actions_server_migrate_dry_run.email}"
}

resource "google_project_iam_member" "github_actions_server_migrate_apply" {
  for_each = local.server_migrate_roles

  project = var.google_cloud_project_id
  role    = each.value
  member  = "serviceAccount:${google_service_account.github_actions_server_migrate_apply.email}"
}

# dry-run 用 SA: server リポジトリの任意のワークフローから借用できる (読み取り専用のため)
resource "google_service_account_iam_member" "github_actions_server_migrate_dry_run_workload_identity_user" {
  service_account_id = google_service_account.github_actions_server_migrate_dry_run.name
  role               = "roles/iam.workloadIdentityUser"
  member             = "principal://iam.googleapis.com/${google_iam_workload_identity_pool.dotto.name}/subject/${var.owner}/server"
}

# 適用用 SA: server リポジトリの GitHub Environment (dev / stg / prd) を指定したジョブからのみ借用できる。
# Environment を指定しない PR のジョブからは借用できない。prd は Environment 側の承認・保護ブランチ制限で守る。
resource "google_service_account_iam_member" "github_actions_server_migrate_apply_workload_identity_user" {
  for_each = local.server_migrate_apply_environments

  service_account_id = google_service_account.github_actions_server_migrate_apply.name
  role               = "roles/iam.workloadIdentityUser"
  member             = "principalSet://iam.googleapis.com/${google_iam_workload_identity_pool.dotto.name}/attribute.repository_environment/${var.owner}/server/${each.value}"
}
