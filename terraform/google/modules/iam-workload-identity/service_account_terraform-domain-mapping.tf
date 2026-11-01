# Cloud Run のドメインマッピングの API は Federated Identity のトークンを受け付けないため、その管理のみこの SA を借用する。
resource "google_service_account" "terraform_domain_mapping" {
  account_id   = "terraform-domain-mapping"
  display_name = "Terraform Domain Mapping"
  description  = "GitHub Actions から dotto-infra の Cloud Run ドメインマッピングを plan / apply するための SA"
}

resource "google_project_iam_member" "terraform_domain_mapping" {
  for_each = toset([
    "roles/run.admin",
    "roles/serviceusage.serviceUsageConsumer", # user_project_override のため
  ])

  project = var.google_cloud_project_id
  role    = each.value
  member  = "serviceAccount:${google_service_account.terraform_domain_mapping.email}"
}

resource "google_service_account_iam_member" "terraform_domain_mapping_token_creator" {
  service_account_id = google_service_account.terraform_domain_mapping.name
  role               = "roles/iam.serviceAccountTokenCreator"
  member             = "principal://iam.googleapis.com/${google_iam_workload_identity_pool.dotto.name}/subject/${var.owner}/infra"
}
