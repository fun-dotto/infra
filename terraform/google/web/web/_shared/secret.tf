# 値は Terraform に載せず、Secret Manager のバージョンとして手動で登録する
resource "google_secret_manager_secret" "notion_token" {
  secret_id = "${var.service_name}-notion-token"

  replication {
    auto {}
  }
}

resource "google_secret_manager_secret_iam_member" "notion_token" {
  secret_id = google_secret_manager_secret.notion_token.id
  role      = "roles/secretmanager.secretAccessor"
  member    = "serviceAccount:${google_service_account.web.email}"
}
