resource "google_iam_workload_identity_pool" "dotto" {
  workload_identity_pool_id = "dotto"
  display_name              = "dotto"
}

resource "google_iam_workload_identity_pool_provider" "github" {
  workload_identity_pool_id          = google_iam_workload_identity_pool.dotto.workload_identity_pool_id
  workload_identity_pool_provider_id = "github"
  display_name                       = "GitHub"

  attribute_mapping = {
    "google.subject" = "assertion.repository"
  }
  attribute_condition = "assertion.repository_owner == \"fun-dotto\""

  oidc {
    issuer_uri = "https://token.actions.githubusercontent.com"
  }
}
