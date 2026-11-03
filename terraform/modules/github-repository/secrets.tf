# 値 (シークレットバージョン) は Terraform 管理外とし、gcloud などで手動登録する
resource "google_secret_manager_secret" "this" {
  for_each = var.secrets

  secret_id = "github_actions_${replace(var.name, "-", "_")}_${lower(each.value)}"

  replication {
    auto {}
  }
}

data "google_secret_manager_secret_version" "this" {
  for_each = var.secrets

  secret = google_secret_manager_secret.this[each.value].secret_id
}

# 値は tfstate に平文で保存される
resource "github_actions_secret" "this" {
  for_each = var.secrets

  repository      = github_repository.this.name
  secret_name     = each.value
  plaintext_value = data.google_secret_manager_secret_version.this[each.value].secret_data
}
