resource "google_secret_manager_secret" "tunnel_token" {
  secret_id = "cloudflared-tunnel-token"

  replication {
    auto {}
  }
}

resource "google_secret_manager_secret_version" "tunnel_token" {
  secret      = google_secret_manager_secret.tunnel_token.id
  secret_data = data.terraform_remote_state.cloudflare.outputs.tunnel_token
}

resource "google_secret_manager_secret_iam_member" "tunnel_token" {
  secret_id = google_secret_manager_secret.tunnel_token.id
  role      = "roles/secretmanager.secretAccessor"
  member    = "serviceAccount:${google_service_account.cloudflared.email}"
}
