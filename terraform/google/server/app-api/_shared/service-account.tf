resource "google_service_account" "server_app_api" {
  account_id   = var.service_account_id
  display_name = var.service_account_display_name
}

resource "google_project_iam_member" "server_app_api" {
  for_each = toset([
    "roles/firebaseappcheck.tokenVerifier",
    "roles/logging.logWriter",
  ])

  project = var.google_cloud_project_id
  role    = each.value
  member  = "serviceAccount:${google_service_account.server_app_api.email}"
}
