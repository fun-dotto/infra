# サービスアカウントの権限借用を介さず、GitHub Actions の Workload Identity に直接ロールを付与する
# (Direct Workload Identity Federation)
locals {
  # リポジトリ => 付与するロール
  direct_workload_identity_roles = {
    admin-web = [
      "roles/artifactregistry.writer",
      "roles/iam.serviceAccountUser", # Cloud Run に実行 SA を設定するため
      "roles/run.developer",
    ]
    server = [
      "roles/artifactregistry.writer",
      "roles/iam.serviceAccountUser", # Cloud Run に実行 SA を設定するため
      "roles/run.developer",
    ]
    web = [
      "roles/artifactregistry.writer",
      "roles/iam.serviceAccountUser", # Cloud Run に実行 SA を設定するため
      "roles/run.developer",
    ]
  }

  direct_workload_identity_bindings = merge([
    for repository, roles in local.direct_workload_identity_roles : {
      for role in roles : "${repository}:${role}" => {
        repository = repository
        role       = role
      }
    }
  ]...)
}

resource "google_project_iam_member" "direct_workload_identity" {
  for_each = local.direct_workload_identity_bindings

  project = var.google_cloud_project_id
  role    = each.value.role
  member  = "principal://iam.googleapis.com/${google_iam_workload_identity_pool.dotto.name}/subject/${var.owner}/${each.value.repository}"
}
