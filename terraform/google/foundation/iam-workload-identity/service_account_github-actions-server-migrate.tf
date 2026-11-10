# fun-dotto/server の Atlas マイグレーション用 SA。環境 (dev / stg / prd) ごとに分けている。
# Cloud SQL Auth Proxy (--auto-iam-authn) 経由で IAM 認証接続する。
# DB 側のユーザーとロールは terraform/google/foundation/cloud-sql で管理する。
# ロール構成は docs/postgresql_roles.md を参照。

locals {
  server_migrate_environments = toset(["dev", "stg", "prd"])

  server_migrate_roles = toset([
    "roles/cloudsql.client",       # Cloud SQL Auth Proxy での接続
    "roles/cloudsql.instanceUser", # IAM 認証でのログイン
  ])

  # SA ごとのプロジェクトロール付与 (キー: "<environment>/<role>")
  server_migrate_project_roles = {
    for pair in setproduct(local.server_migrate_environments, local.server_migrate_roles) :
    "${pair[0]}/${pair[1]}" => {
      environment = pair[0]
      role        = pair[1]
    }
  }
}

# dry-run 用 (読み取り専用): pull_request / merge_group で使う
resource "google_service_account" "github_actions_server_migrate_dry_run" {
  for_each = local.server_migrate_environments

  account_id   = "gha-server-migrate-dry-run-${each.key}"
  display_name = "GitHub Actions (server migrate dry-run ${each.key})"
  description  = "fun-dotto/server の Atlas マイグレーション dry-run 専用 SA (${each.key} の DB 読み取りのみ)"
}

# 適用用 (DDL 権限あり): main への push と workflow_dispatch で使う
resource "google_service_account" "github_actions_server_migrate_apply" {
  for_each = local.server_migrate_environments

  account_id   = "gha-server-migrate-apply-${each.key}"
  display_name = "GitHub Actions (server migrate apply ${each.key})"
  description  = "fun-dotto/server の Atlas マイグレーション適用専用 SA (${each.key} の dotto_admin_${each.key})"
}

resource "google_project_iam_member" "github_actions_server_migrate_dry_run" {
  for_each = local.server_migrate_project_roles

  project = var.google_cloud_project_id
  role    = each.value.role
  member  = "serviceAccount:${google_service_account.github_actions_server_migrate_dry_run[each.value.environment].email}"
}

resource "google_project_iam_member" "github_actions_server_migrate_apply" {
  for_each = local.server_migrate_project_roles

  project = var.google_cloud_project_id
  role    = each.value.role
  member  = "serviceAccount:${google_service_account.github_actions_server_migrate_apply[each.value.environment].email}"
}

# dry-run 用 SA: server リポジトリの任意のワークフローから借用できる (読み取り専用のため)
resource "google_service_account_iam_member" "github_actions_server_migrate_dry_run_workload_identity_user" {
  for_each = local.server_migrate_environments

  service_account_id = google_service_account.github_actions_server_migrate_dry_run[each.key].name
  role               = "roles/iam.workloadIdentityUser"
  member             = "principal://iam.googleapis.com/${google_iam_workload_identity_pool.dotto.name}/subject/${var.owner}/server"
}

# 適用用 SA: server リポジトリの同名の GitHub Environment を指定したジョブからのみ借用できる。
# Environment を指定しない PR のジョブや、ほかの環境のジョブからは借用できない。
# prd は Environment 側の承認・保護ブランチ制限で守る。
resource "google_service_account_iam_member" "github_actions_server_migrate_apply_workload_identity_user" {
  for_each = local.server_migrate_environments

  service_account_id = google_service_account.github_actions_server_migrate_apply[each.key].name
  role               = "roles/iam.workloadIdentityUser"
  member             = "principalSet://iam.googleapis.com/${google_iam_workload_identity_pool.dotto.name}/attribute.repository_environment/${var.owner}/server/${each.key}"
}
