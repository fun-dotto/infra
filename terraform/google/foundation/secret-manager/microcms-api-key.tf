# microCMS の articles API の GET 権限のみを持つ API キー。dev / stg / prd で共有する。
# 値は Terraform に載せず、Secret Manager のバージョンとして手動で登録する
resource "google_secret_manager_secret" "microcms_api_key" {
  secret_id = "microcms-api-key"

  replication {
    auto {}
  }
}
