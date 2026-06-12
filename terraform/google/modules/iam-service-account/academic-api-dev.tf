resource "google_service_account" "academic_api_dev" {
  account_id   = "academic-api-dev"
  display_name = "academic-api-dev"
}

resource "google_project_iam_member" "academic_api_dev" {
  for_each = toset([
    "roles/cloudsql.client",
    "roles/cloudsql.instanceUser",
  ])

  project = var.google_cloud_project_id
  role    = each.value
  member  = "serviceAccount:${google_service_account.academic_api_dev.email}"
}
