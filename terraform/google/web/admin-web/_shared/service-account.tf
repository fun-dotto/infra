resource "google_service_account" "web_admin_web" {
  account_id   = var.service_account_id
  display_name = var.service_account_display_name
}

resource "google_project_iam_member" "web_admin_web" {
  for_each = toset([
    "roles/logging.logWriter",
  ])

  project = var.google_cloud_project_id
  role    = each.value
  member  = "serviceAccount:${google_service_account.web_admin_web.email}"
}
