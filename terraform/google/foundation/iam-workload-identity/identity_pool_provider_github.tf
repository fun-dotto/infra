resource "google_iam_workload_identity_pool_provider" "github" {
  workload_identity_pool_id          = google_iam_workload_identity_pool.dotto.workload_identity_pool_id
  workload_identity_pool_provider_id = "github"
  display_name                       = "GitHub"

  # attribute.repository_environment は "<owner>/<repo>/<environment>" 形式。
  # GitHub Environment を使わないジョブでは末尾が空になる。
  # Environment 単位でサービスアカウントの借用を制限するために使う（例: マイグレーション適用用 SA）
  attribute_mapping = {
    "google.subject"                   = "assertion.repository"
    "attribute.repository_environment" = "assertion.repository + \"/\" + (has(assertion.environment) ? assertion.environment : \"\")"
  }
  attribute_condition = "assertion.repository_owner == \"${var.owner}\""

  oidc {
    issuer_uri = "https://token.actions.githubusercontent.com"
  }
}
