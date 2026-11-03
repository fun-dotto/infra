# Organization 全体の GitHub Actions Secret
# 値は空文字で作成し、実際の値は GitHub 上で手動登録する (Terraform では値の変更を無視する)
locals {
  organization_secrets = toset([
    "DOTTO_APPLE_CERTIFICATES_USER_APP_PRIVATE_KEY",
    "DOTTO_GITHUB_MANAGER_APP_PRIVATE_KEY",
    "DOTTO_PROTO_UPDATER_APP_PRIVATE_KEY",
  ])
}

resource "github_actions_organization_secret" "this" {
  for_each = local.organization_secrets

  secret_name = each.value
  value       = ""
  visibility  = "all"

  lifecycle {
    # GitHub 上で値を更新しても上書きしない
    ignore_changes = [value, remote_updated_at]
  }
}
