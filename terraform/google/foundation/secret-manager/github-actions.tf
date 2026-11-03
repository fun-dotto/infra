# GitHub Actions の Secret として配布する値
# 値 (シークレットバージョン) は Terraform 管理外とし、gcloud などで手動登録する
# 配布は terraform/github/fun-dotto/repository-*.tf で行う
locals {
  github_actions_secret_ids = toset([
    "github_actions_android_keystore_base64",
    "github_actions_android_keystore_password",
    "github_actions_app_store_connect_api_key_content_base64",
    "github_actions_cloudflare_api_token",
    "github_actions_cloudflare_github_idp_client_secret",
    "github_actions_match_git_app_private_key",
    "github_actions_match_password",
    "github_actions_proto_updater_app_private_key",
    "github_actions_slack_url",
    "github_actions_terraform_github_app_private_key",
  ])
}

resource "google_secret_manager_secret" "github_actions" {
  for_each = local.github_actions_secret_ids

  secret_id = each.value

  replication {
    auto {}
  }
}
