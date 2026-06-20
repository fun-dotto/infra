resource "google_service_account" "github_actions" {
  account_id   = "github-actions"
  display_name = "GitHub Actions"
}

resource "google_project_iam_member" "github_actions" {
  for_each = toset([
    "roles/artifactregistry.writer",
    "roles/iam.serviceAccountUser",
    "roles/iam.workloadIdentityUser",
    "roles/run.admin",
  ])

  project = var.google_cloud_project_id
  role    = each.value
  member  = "serviceAccount:${google_service_account.github_actions.email}"
}

resource "google_service_account_iam_member" "github_actions_workload_identity_user" {
  for_each = toset([
    "admin-web",
    "app",
    "server",
    "web",
  ])

  service_account_id = "projects/${var.google_cloud_project_id}/serviceAccounts/${google_service_account.github_actions.email}"
  role               = "roles/iam.workloadIdentityUser"
  member             = "principal://iam.googleapis.com/${google_iam_workload_identity_pool.dotto.name}/subject/${var.owner}/${each.value}"
}
