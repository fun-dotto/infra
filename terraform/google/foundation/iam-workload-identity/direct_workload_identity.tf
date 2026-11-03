# サービスアカウントの権限借用を介さず、GitHub Actions の Workload Identity に直接ロールを付与する
# (Direct Workload Identity Federation)
locals {
  direct_workload_identity_repositories = toset([
    "admin-web",
    "server",
    "web",
  ])

  direct_workload_identity_roles = toset([
    "roles/artifactregistry.writer",
    "roles/iam.serviceAccountUser", # Cloud Run に実行 SA を設定するため
    "roles/run.developer",
  ])

  direct_workload_identity_bindings = {
    for pair in setproduct(local.direct_workload_identity_repositories, local.direct_workload_identity_roles) :
    "${pair[0]}:${pair[1]}" => {
      repository = pair[0]
      role       = pair[1]
    }
  }
}

resource "google_project_iam_member" "direct_workload_identity" {
  for_each = local.direct_workload_identity_bindings

  project = var.google_cloud_project_id
  role    = each.value.role
  member  = "principal://iam.googleapis.com/${google_iam_workload_identity_pool.dotto.name}/subject/${var.owner}/${each.value.repository}"
}
