resource "google_service_account" "terraform_ci" {
  account_id   = "terraform-ci"
  display_name = "Terraform CI"
  description  = "GitHub Actions から dotto-infra の Terraform を plan / apply するための SA"
}

resource "google_project_iam_member" "terraform_ci" {
  for_each = toset([
    "roles/artifactregistry.admin",
    "roles/browser", # google_project の読み取り
    "roles/cloudconfig.admin",
    "roles/cloudscheduler.admin",
    "roles/cloudsql.admin",
    "roles/compute.networkAdmin",
    "roles/dns.admin",
    "roles/firebase.admin",
    "roles/iam.serviceAccountAdmin",
    "roles/iam.serviceAccountUser", # Cloud Run・Cloud Scheduler に実行 SA を設定するため
    "roles/iam.workloadIdentityPoolAdmin",
    "roles/monitoring.alertPolicyEditor",
    "roles/monitoring.notificationChannelEditor",
    "roles/resourcemanager.projectIamAdmin",
    "roles/run.admin",
    "roles/secretmanager.admin",
    "roles/serviceusage.serviceUsageConsumer", # user_project_override のため
    "roles/storage.admin",                     # tfstate・Digger の PR lock を含む
  ])

  project = var.google_cloud_project_id
  role    = each.value
  member  = "serviceAccount:${google_service_account.terraform_ci.email}"
}

resource "google_service_account_iam_member" "terraform_ci_workload_identity_user" {
  for_each = toset([
    "infra",
  ])

  service_account_id = "projects/${var.google_cloud_project_id}/serviceAccounts/${google_service_account.terraform_ci.email}"
  role               = "roles/iam.workloadIdentityUser"
  member             = "principal://iam.googleapis.com/${google_iam_workload_identity_pool.dotto.name}/subject/${var.owner}/${each.value}"
}
