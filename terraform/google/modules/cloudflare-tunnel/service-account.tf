resource "google_service_account" "cloudflared" {
  account_id   = "cloudflared"
  display_name = "Cloudflare Tunnel"
}

resource "google_project_iam_member" "cloudflared_log_writer" {
  project = var.google_cloud_project_id
  role    = "roles/logging.logWriter"
  member  = "serviceAccount:${google_service_account.cloudflared.email}"
}
