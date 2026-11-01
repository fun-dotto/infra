# 値は Terraform に載せず、Secret Manager のバージョンとして手動で登録する
resource "google_secret_manager_secret" "notion_token" {
  secret_id = "web-stg-notion-token"

  replication {
    auto {}
  }
}
