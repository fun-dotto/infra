# infra リポジトリの Digger が Service Account を借用せずに Terraform を実行するための権限
# Federated Identity には roles/owner を付与できないため、管理対象リソースごとに predefined role を付与する。
resource "google_project_iam_member" "infra" {
  for_each = toset([
    "roles/artifactregistry.admin",
    "roles/browser", # google_project の読み取り
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
  member  = "principal://iam.googleapis.com/${google_iam_workload_identity_pool.dotto.name}/subject/${var.owner}/infra"
}
