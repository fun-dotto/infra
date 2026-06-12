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
