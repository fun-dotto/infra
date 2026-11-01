resource "google_secret_manager_secret" "cf_access_client_secret" {
  project   = "swift2023groupc"
  secret_id = "admin-web-cf-access-client-secret"

  replication {
    auto {}
  }
}

resource "google_secret_manager_secret_version" "cf_access_client_secret" {
  secret      = google_secret_manager_secret.cf_access_client_secret.id
  secret_data = data.terraform_remote_state.cloudflare.outputs.admin_web_service_token_client_secrets["prd"]
}
