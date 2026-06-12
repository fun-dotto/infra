locals {
  github_actions_service_account = "github-actions@${var.google_cloud_project_id}.iam.gserviceaccount.com"

  github_actions_repositories = [
    "academic-api",
    "admin-bff-api",
    "announcement-api",
    "app-bff-api",
    "dotto-admin-web",
    "dotto-web",
    "funch-api",
    "user-api",
  ]
}

resource "google_service_account_iam_member" "github_actions_workload_identity_user" {
  for_each = toset(local.github_actions_repositories)

  service_account_id = "projects/${var.google_cloud_project_id}/serviceAccounts/${local.github_actions_service_account}"
  role               = "roles/iam.workloadIdentityUser"
  member             = "principal://iam.googleapis.com/${google_iam_workload_identity_pool.dotto.name}/subject/fun-dotto/${each.value}"
}
