# サービスアカウントの権限借用を介さず、GitHub Actions の Workload Identity に直接ロールを付与する
# (Direct Workload Identity Federation)
resource "google_project_iam_member" "workload_identity" {
  for_each = var.workload_identity_roles

  project = var.google_cloud_project_id
  role    = each.value
  member  = "principal://iam.googleapis.com/${var.workload_identity_pool_name}/subject/${github_repository.this.full_name}"
}
