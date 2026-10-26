resource "google_service_account" "cloudflared" {
  account_id   = "cloudflared"
  display_name = "cloudflared"
}

resource "google_project_iam_member" "cloudflared" {
  for_each = toset([
    "roles/logging.logWriter",
  ])

  project = var.google_cloud_project_id
  role    = each.value
  member  = "serviceAccount:${google_service_account.cloudflared.email}"
}
