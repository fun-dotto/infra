# Firebase の API は Federated Identity のトークンを受け付けないため、Firebase の管理のみこの SA を借用する。
resource "google_service_account" "terraform_firebase" {
  account_id   = "terraform-firebase"
  display_name = "Terraform Firebase"
  description  = "GitHub Actions から dotto-infra の Firebase リソースを plan / apply するための SA"
}

resource "google_project_iam_member" "terraform_firebase" {
  for_each = toset([
    "roles/firebase.viewer",
    "roles/cloudconfig.admin",
    "roles/serviceusage.serviceUsageConsumer", # user_project_override のため
  ])

  project = var.google_cloud_project_id
  role    = each.value
  member  = "serviceAccount:${google_service_account.terraform_firebase.email}"
}

resource "google_service_account_iam_member" "terraform_firebase_token_creator" {
  service_account_id = google_service_account.terraform_firebase.name
  role               = "roles/iam.serviceAccountTokenCreator"
  member             = "principal://iam.googleapis.com/${google_iam_workload_identity_pool.dotto.name}/subject/${var.owner}/infra"
}
