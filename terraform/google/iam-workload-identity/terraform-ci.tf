# infra リポジトリの GitHub Actions が terraform-ci SA を借用できるようにする。
# subject は attribute_mapping (google.subject = assertion.repository) により
# "fun-dotto/infra" となる。
resource "google_service_account_iam_member" "terraform_ci_workload_identity_user" {
  service_account_id = "projects/${var.google_cloud_project_id}/serviceAccounts/terraform-ci@${var.google_cloud_project_id}.iam.gserviceaccount.com"
  role               = "roles/iam.workloadIdentityUser"
  member             = "principal://iam.googleapis.com/${google_iam_workload_identity_pool.dotto.name}/subject/fun-dotto/infra"
}
