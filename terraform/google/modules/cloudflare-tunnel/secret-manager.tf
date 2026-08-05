resource "google_secret_manager_secret" "tunnel_token" {
  secret_id = var.tunnel_token_secret_id

  replication {
    auto {}
  }

  depends_on = [google_project_service.required]
}

resource "google_secret_manager_secret_iam_member" "cloudflared" {
  secret_id = google_secret_manager_secret.tunnel_token.id
  role      = "roles/secretmanager.secretAccessor"
  member    = "serviceAccount:${google_service_account.cloudflared.email}"
}
