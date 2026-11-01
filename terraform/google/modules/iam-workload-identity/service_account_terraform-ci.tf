resource "google_service_account" "terraform_ci" {
  account_id   = "terraform-ci"
  display_name = "Terraform CI"
  description  = "GitHub Actions から dotto-infra の Terraform を plan / apply するための SA"
}

resource "google_project_iam_member" "terraform_ci" {
  for_each = toset([
    "roles/owner", # 全リソースを管理するため、オーナーロールを付与する。
    "roles/artifactregistry.admin",
    "roles/browser",
    "roles/cloudconfig.admin",
    "roles/cloudscheduler.admin",
    "roles/cloudsql.admin",
    "roles/compute.networkAdmin",
    "roles/dns.admin",
    "roles/firebase.admin",
    "roles/iam.serviceAccountAdmin",
    "roles/iam.serviceAccountUser",
    "roles/iam.workloadIdentityPoolAdmin",
    "roles/monitoring.alertPolicyEditor",
    "roles/monitoring.notificationChannelEditor",
    "roles/resourcemanager.projectIamAdmin",
    "roles/run.admin",
    "roles/secretmanager.admin",
    "roles/serviceusage.serviceUsageConsumer",
    "roles/storage.admin",
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
